import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../client.dart';

class ClientMasterInfoScreen extends StatefulWidget {
  final int? id;

  const ClientMasterInfoScreen({super.key, this.id});

  @override
  State<ClientMasterInfoScreen> createState() => _ClientMasterInfoScreenState();
}

class _ClientMasterInfoScreenState extends State<ClientMasterInfoScreen> {
  final infoController = GetIt.instance<ClientMasterInfoController>();
  final reviewsController = GetIt.instance<ClientMasterReviewsController>();
  final controller = GetIt.instance<ClientMasterInfoStateController>();

  MasterInfoTabState tab = MasterInfoTabState.services;

  @override
  void initState() {
    infoController.setContext(context);
    reviewsController.setContext(context);

    reviewsController.setupParams(widget.id);
    reviewsController.fetchReviews();

    infoController.fetchMasterInfo(widget.id ?? 0, () {
      controller.initData(infoController.data, context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(builder: (context) {
          if (!infoController.stateManager.isSuccess) {
            return CustomScrollView(
              slivers: [
                const AppBarWithStyledLeading(
                  title: '',
                  isSliver: true,
                ),
                StateControlWidget(
                  props: StateControlWidgetProps(
                    isLoading: infoController.stateManager.isLoading,
                    isError: infoController.stateManager.isError,
                    isEmpty: infoController.items.isEmpty,
                    onError: () {
                      infoController.fetchMasterInfo(widget.id ?? 0, () {
                        controller.initData(infoController.data, context);
                      });
                    },
                    isSliver: true,
                  ),
                ),
              ],
            );
          }
          final master = controller.data;
          final services = master?.services;
          return CustomScrollView(
            slivers: [
              ClientMasterInfoExpandedStyledAppBar(
                master: master,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                    vertical: AppDimensions.paddingMedium,
                  ),
                  child: MasterProfileWidget(
                    master: controller.data,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 70.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingLarge,
                        vertical: AppDimensions.paddingMedium),
                    child: AnimatedToggleWidget<MasterInfoTabState?>(
                      initialValue: tab,
                      onChanged: (value) {
                        if (value == null || tab == value) {
                          return;
                        }
                        setState(() {
                          tab = value;
                        });
                      },
                      props: const AnimatedToggleWidgetProps(),
                      items: [
                        AnimatedToggleWidgetItem(
                          value: MasterInfoTabState.services,
                          title: context.loc.my_services,
                        ),
                        AnimatedToggleWidgetItem(
                          value: MasterInfoTabState.about,
                          title: context.loc.about_me,
                        ),
                        AnimatedToggleWidgetItem(
                          value: MasterInfoTabState.reviews,
                          title: context.loc.reviews,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Observer(
                  builder: (context) {
                    if (tab != MasterInfoTabState.services) {
                      return const SizedBox();
                    }
                    return ClientMasterInfoHorizontalCategoriesList(
                      onServiceTap: (value) {
                        controller.changeCurrentSelectedServiceId(value);
                      },
                      services: services,
                      selectedServiceId: controller.selectedServiceId,
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: Observer(builder: (context) {
                  switch (tab) {
                    case MasterInfoTabState.services:
                      return ServicesTab(
                        onChooseTap: (value) {
                          controller.chooseService(value);
                        },
                        chosenServices: controller.chosenServices,
                        subservices: controller.subservices,
                      );
                    case MasterInfoTabState.about:
                      return MasterProfileAboutMeWidget(
                        master: master,
                      );
                    case MasterInfoTabState.reviews:
                      return SliverList.separated(
                        itemBuilder: (context, index) {
                          final review = reviewsController.items[index];
                          return ReviewWidgetWithRating(
                            review: review,
                            masterInfo: master!,
                          );
                        },
                        itemCount: reviewsController.items.length,
                        separatorBuilder: (_, __) {
                          return const VSpacer(AppDimensions.paddingMedium);
                        },
                      );
                  }
                }),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: Observer(builder: (context) {
          if (tab != MasterInfoTabState.services ||
              controller.chosenServices.isEmpty) {
            return const SizedBox();
          }
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingMedium),
            child: ElevatedButton(
              onPressed: () {
                controller.handleOnContinue();
                if (controller.chosenServicesToSendDto == null) {
                  return;
                }
                context.pushNamed(
                  ClientRoutes.booking,
                  extra: BookingInfoRouteModel(
                    masterInfo: controller.data,
                    chosenServicesToSendDto: controller.chosenServicesToSendDto,
                  ),
                );
              },
              child: Text(
                  '${context.loc.choose_date} (${controller.chosenServices.length})'),
            ),
          );
        }),
      ),
    );
  }
}

class ClientMasterInfoHorizontalCategoriesList extends StatelessWidget {
  final List<ClientMasterServiceDto>? services;
  final ValueChanged<int?> onServiceTap;
  final int? selectedServiceId;

  const ClientMasterInfoHorizontalCategoriesList({
    super.key,
    this.services,
    required this.onServiceTap,
    required this.selectedServiceId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services?.length ?? 0,
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
        separatorBuilder: (_, __) {
          return const HSpacer(AppDimensions.paddingMedium);
        },
        itemBuilder: (context, index) {
          final element = services?[index];
          final isSelected = element?.serviceId == selectedServiceId;
          return GestureDetector(
            onTap: () {
              onServiceTap(element?.serviceId);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.radiusMedium),
                ),
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              ),
              margin: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingMedium),
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.paddingMedium,
                horizontal: AppDimensions.paddingSmall +
                    AppDimensions.paddingExtraSmall,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (element?.serviceId == -1) ...[
                    const Icon(Icons.category_outlined),
                  ] else ...[
                    const SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CachingSVGImage(null)),
                  ],
                  const HSpacer(AppDimensions.paddingSmall),
                  Text(
                    element?.name ?? '',
                    style: context.textTheme.containerTitle,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ClientMasterInfoExpandedStyledAppBar extends StatelessWidget {
  final ClientMasterInfoDto? master;

  const ClientMasterInfoExpandedStyledAppBar({super.key, this.master});

  @override
  Widget build(BuildContext context) {
    final portfolioImages = master?.portfolio;

    return SliverAppBar(
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      expandedHeight: 180.0,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        double collapseProgress =
            (constraints.maxHeight - kToolbarHeight) / (180.0 - kToolbarHeight);

        bool isCollapsed = collapseProgress < 0.15;
        final titleWidget = isCollapsed
            ? Text(
                master?.fullName ?? '',
                style: context.textTheme.appTitle,
              )
            : null;
        return FlexibleSpaceBar(
          title: titleWidget,
          collapseMode: CollapseMode.parallax,
          expandedTitleScale: 1.0,
          centerTitle: true,
          background: CarouselWithStackIndicators(
            height: 180.0,
            carouselItems: portfolioImages?.map((value) {
                  return CachingImage(value.imageName ?? '');
                }).toList() ??
                [],
          ),
        );
      }),
      leadingWidth: 100.0,
      leading: StyledBackButton(
        onTap: () {
          context.pop();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge),
          child: SizedBox(
            height: 40.0,
            width: 40.0,
            child: PopupMenuButton(
              style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.radiusMedium),
                  ),
                ),
                padding: EdgeInsets.zero,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.radiusMedium),
                ),
              ),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.loc.report,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ),
                        const HSpacer(AppDimensions.paddingExtraLarge),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).colorScheme.error,
                          size: 19.0,
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MasterProfileAboutMeWidget extends StatelessWidget {
  final ClientMasterInfoDto? master;

  const MasterProfileAboutMeWidget({super.key, required this.master});

  @override
  Widget build(BuildContext context) {
    final workshifts = master?.workshifts;
    return SliverList.list(children: [
      // Divider(),
      Text(
        context.loc.about_me,
        style: context.textTheme.appTitle,
      ),
      const VSpacer(AppDimensions.paddingMedium),
      Text(master?.aboutMe ?? ''),
      const Divider(
        height: AppDimensions.paddingLarge * 2,
      ),
      Text(
        context.loc.know_languages,
        style: context.textTheme.appTitle,
      ),
      const VSpacer(AppDimensions.paddingMedium),
      Row(
        spacing: AppDimensions.paddingLarge,
        children: master?.languages?.map((lang) {
              return Text(lang.langName ?? '');
            }).toList() ??
            [],
      ),
      const Divider(
        height: AppDimensions.paddingLarge * 2,
      ),
      Text(
        context.loc.service_location,
        style: context.textTheme.appTitle,
      ),
      const VSpacer(AppDimensions.paddingMedium),
      Row(
        spacing: AppDimensions.paddingLarge,
        children: master?.workingLocations?.map((location) {
              return Text(location.workingLocationName ?? '');
            }).toList() ??
            [],
      ),
      const Divider(
        height: AppDimensions.paddingLarge * 2,
      ),
      Text(
        context.loc.working_hours,
        style: context.textTheme.appTitle,
      ),
      const VSpacer(AppDimensions.paddingMedium),
      StyledContainerWithColumn(
        items: workshifts?.asMap().entries.map((entry) {
              final index = entry.key;
              final isToday = DateTime.now().weekday == index + 1;

              return WorkingHourRow(
                isToday: isToday,
                index: index,
                length: workshifts.length,
                shift: entry.value,
              );
            }).toList() ??
            [],
      ),
    ]);
  }
}

class MasterProfileWidget extends StatelessWidget {
  final ClientMasterInfoDto? master;

  const MasterProfileWidget({super.key, required this.master});

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 140.0,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.radiusMedium),
          ),
        ),
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          children: [
            SizedBox(
              height: 70.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 70.0,
                    width: 70.0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimensions.radiusMedium),
                      ),
                      child: CachingImage(
                        master?.userImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const HSpacer(AppDimensions.paddingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          master?.fullName ?? '',
                          style: context.textTheme.containerTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            const CachingImage(
                              null,
                              height: 12.0,
                              width: 20.0,
                            ),
                            const HSpacer(AppDimensions.paddingExtraSmall),
                            Text(master?.profileName ?? ''),
                            const HSpacer(AppDimensions.paddingMedium),
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.yellow,
                            ),
                            const HSpacer(AppDimensions.paddingExtraSmall),
                            Text(
                                '${(master?.avgRating ?? 0).toStringAsFixed(2)} (${master?.reviewsCount ?? 0})'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.man,
                              size: 20.0,
                            ),
                            const HSpacer(AppDimensions.paddingExtraSmall),
                            Text(master?.gender ?? ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: LikeButton(
                      master: ClientMasterDto.fromClientMasterInfoDto(master),
                      favoritesController:
                          GetIt.instance<ClientFavoritesStateController>(),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_outlined),
                const HSpacer(AppDimensions.paddingSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${master?.cityName}, ${master?.regionName ?? ''}',
                      ),
                      Text(
                        master?.address ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class ReviewWidgetWithRating extends StatelessWidget {
  final ClientMasterReviewDto review;
  final ClientMasterInfoDto masterInfo;

  const ReviewWidgetWithRating(
      {super.key, required this.review, required this.masterInfo});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReviewAvatarAndTitle(
              masterName: review.client?.name,
              createdAt: review.date,
            ),
            const VSpacer(AppDimensions.paddingSmall),
            const RatingWidget(
              rating: 5,
            ),
            const VSpacer(AppDimensions.paddingSmall),
            Text(review.text ?? ''),
            const VSpacer(AppDimensions.paddingLarge),
            if (review.masterReply != null)
              ReplyWidget(
                masterInfo: masterInfo,
                reply: review.masterReply!,
              ),
          ],
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final int? rating;

  const RatingWidget({super.key, this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.filled(
          rating ?? 0,
          const Icon(
            Icons.star_rounded,
            color: AppColors.yellow,
          ),
        ),
        if ((rating ?? 0) < 5)
          ...List.filled(
            5 - (rating ?? 0),
            const Icon(
              Icons.star_outline_rounded,
              color: AppColors.yellow,
            ),
          ),
      ],
    );
  }
}

class ReplyWidget extends StatelessWidget {
  final MasterReply reply;
  final ClientMasterInfoDto masterInfo;

  const ReplyWidget({super.key, required this.reply, required this.masterInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const HSpacer(AppDimensions.paddingExtraLarge * 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReviewAvatarAndTitle(
                masterName: masterInfo.fullName,
                createdAt: reply.replyCreatedAt,
              ),
              const VSpacer(AppDimensions.paddingSmall),
              Text(reply.replyText ?? ''),
            ],
          ),
        ),
      ],
    );
  }
}

class ReviewAvatarAndTitle extends StatelessWidget {
  final String? masterName;
  final String? createdAt;

  const ReviewAvatarAndTitle({super.key, this.masterName, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: context.colorScheme.reviewAvatarColor,
          radius: 25.0,
          child: Text(
            masterName?.substring(0, 1) ?? 'B',
            style: context.textTheme.appTitle.copyWith(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        const HSpacer(AppDimensions.paddingMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                masterName ?? 'Belle',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                createdAt ?? '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WorkingHourRow extends StatelessWidget {
  final bool isToday;
  final int index;
  final int length;
  final Workshift shift;

  const WorkingHourRow({
    super.key,
    required this.isToday,
    required this.index,
    required this.length,
    required this.shift,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isToday ? Theme.of(context).colorScheme.primary : null;
    final baseTextStyle = Theme.of(context).textTheme.bodyMedium;
    final textStyle = baseTextStyle?.copyWith(color: textColor);

    return DualToneContainer(
      index: index,
      length: length,
      child: Row(
        children: [
          Expanded(
            child: Text(
              DateTimeParser.getWeekdayName(context, shift.days ?? 0),
              style: textStyle,
            ),
          ),
          Text(
            '${shift.dayStart} - ${shift.dayEnd}',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class ServicesTab extends StatelessWidget {
  final ValueChanged<int?> onChooseTap;
  final List<int?> chosenServices;
  final List<Subservice> subservices;

  const ServicesTab({
    super.key,
    required this.onChooseTap,
    required this.chosenServices,
    required this.subservices,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: subservices.length,
      itemBuilder: (context, index) {
        final service = subservices[index];
        return Container(
          margin:
              const EdgeInsets.symmetric(vertical: AppDimensions.paddingSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimensions.radiusMedium),
            ),
          ),
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('${service.time} min - ${service.prices?.price} TMT'),
                  ],
                ),
              ),
              const HSpacer(AppDimensions.paddingLarge),
              Expanded(
                child: Observer(builder: (context) {
                  void func() {
                    onChooseTap(service.subserviceId);
                  }

                  if (chosenServices.contains(service.subserviceId)) {
                    return ElevatedButton(
                      onPressed: func,
                      child: Text(context.loc.chosen),
                    );
                  }
                  return OutlinedButton(
                    onPressed: func,
                    child: Text(context.loc.choose),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum MasterInfoTabState { services, about, reviews }

extension AddOrRemoveExtension<T> on List {
  void changeState(T value) {
    if (contains(value)) {
      remove(value);
    } else {
      add(value);
    }
  }
}
