import 'package:belle/src/core/core.dart';
import 'package:belle/src/utils/src/helpers/show_snack_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../../client.dart';

class BookingScreen extends StatefulWidget {
  final ClientMasterInfoDto? masterInfo;
  final ChosenServicesToSendDto? chosenServicesToSendDto;

  const BookingScreen({
    super.key,
    required this.masterInfo,
    required this.chosenServicesToSendDto,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final controller = GetIt.instance<BookingController>();
  final stateController = GetIt.instance<BookingStateController>();
  final calendarController = GetIt.instance<BookingCalendarController>();
  final scrollController = ScrollController();
  final GlobalKey _dayChooserListKey = GlobalKey();
  bool firstOpen = true;

  Widget _buildDivider(BuildContext context, TimeOfDay? time) {
    if (time == null) return const SizedBox.shrink();

    final disabledSlots = stateController.disabledSlots.toSet();
    final isDisabled = disabledSlots.contains(time);

    Color color = Theme.of(context).colorScheme.secondaryContainer;
    if (isDisabled) {
      color = Theme.of(context).colorScheme.surface;
    }

    return SizedBox(
      width: 55.0,
      child: Divider(
        height: 0.0,
        color: color,
      ),
    );
  }

  void _scrollToDayChooserList(Duration timeStamp) {
    if (!firstOpen) {
      return;
    }
    final RenderObject? renderObject =
        _dayChooserListKey.currentContext?.findRenderObject();
    if (renderObject != null && renderObject is RenderSliver) {
      final RenderSliver renderSliver = renderObject;
      final double targetOffset =
          renderSliver.constraints.precedingScrollExtent - 250.0;
      scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
    firstOpen = false;
  }

  Widget _buildButton(BuildContext context, TimeOfDay? time) {
    if (time == null) return const SizedBox.shrink();

    final disabledSlots = stateController.disabledSlots.toSet();
    final selectedSlots = stateController.selectedSlots.toSet();

    final isDisabled = disabledSlots.contains(time);
    final isSelected = selectedSlots.contains(time);

    final title = MaterialLocalizations.of(context).formatTimeOfDay(
      time,
      alwaysUse24HourFormat: true,
    );

    if (isDisabled) {
      return SizedBox(
        width: 75.0,
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          child: Text(title),
        ),
      );
    }

    return SizedBox(
      width: 75.0,
      child: ElevatedButton(
        onPressed: () {
          stateController.onSelectSlotTap(time, context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
        child: Text(title),
      ),
    );
  }

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);
    calendarController.setContext(context);
    if (widget.masterInfo?.workingLocationsIds != null &&
        (widget.masterInfo?.workingLocationsIds.isNotEmpty ?? false)) {
      stateController.changeCurrentServiceLocationId(
        widget.masterInfo?.workingLocationsIds.first,
      );
    }
    getDataAndInit();
    super.initState();
  }

  void getDataAndInit() {
    controller.postChosenServices(widget.chosenServicesToSendDto, (value) {
      stateController.init(value);
      calendarController.init(value);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.booking,
        isSliver: false,
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (!controller.stateManager.isSuccess) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                isLoading: controller.stateManager.isLoading,
                isError: controller.stateManager.isError,
                isEmpty: controller.data == null,
                onError: () {
                  getDataAndInit();
                },
                // isSliver: true,
              ),
            );
          }
          WidgetsBinding.instance.addPostFrameCallback(_scrollToDayChooserList);
          final data = controller.data;
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    context.loc.chosen_services(
                        '${controller.data?.services?.length ?? 0}'),
                    style: context.textTheme.appTitle,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverToBoxAdapter(
                  child: StyledContainerWithColumn(
                    items: [
                      for (int i = 0; i < (data?.services?.length ?? 0); i++)
                        Builder(builder: (context) {
                          final service = data?.services?[i];
                          final price =
                              '${service?.fixPrice ?? '${service?.minPrice} - ${service?.maxPrice}'} TMT';
                          return DualToneContainer(
                            index: i,
                            length: controller.data?.services?.length ?? 0,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service?.subserviceName ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        price,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final updatedServices =
                                        stateController.deleteFromServices(i);
                                    final chosenServicesToSendDto = widget
                                        .chosenServicesToSendDto
                                        ?.copyWith(
                                      subServicesIds: updatedServices,
                                    );
                                    controller.postChosenServices(
                                        chosenServicesToSendDto, (value) {
                                      stateController.init(value);
                                    });
                                  },
                                  icon: const Icon(Icons.close_rounded),
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ],
                            ),
                          );
                        }),
                      ServicesTotalInfoWidget(
                        data: data,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverToBoxAdapter(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final result =
                          await context.pushNamed<BookingInfoRouteModel?>(
                        ClientRoutes.masterServices,
                        extra: MasterServicesRouteModel(
                          masterId: widget.masterInfo?.id,
                          chosenServices:
                              stateController.getServicesIds() ?? [],
                        ),
                      );
                      if (result == null) {
                        return;
                      }
                      controller.postChosenServices(
                          result.chosenServicesToSendDto, (value) {
                        stateController.init(value);
                      });
                    },
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.add),
                    label: Text(context.loc.add_more),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverList.list(
                  children: [
                    Text(
                      context.loc.choose_your_day,
                      style: context.textTheme.appTitle,
                    ),
                    const VSpacer(AppDimensions.paddingSmall),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: DayChooserList(
                  currentDate: stateController.selectedDate,
                  availableDates: stateController.responseModel?.calendar?.dates
                          ?.map((el) => el.date ?? DateTime.now())
                          .toList() ??
                      [],
                  onChooseDate: (value) {
                    stateController.onSelectDateTap(value);
                  },
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverToBoxAdapter(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Observer(builder: (context) {
                            return AvailableDatesCalendarWidget(
                              onDateChanged: (value) {
                                stateController.onSelectDateTap(value);
                              },
                              focusedDay: stateController.selectedDate,
                              onPageChanged: (value) {
                                stateController.onSelectDateTap(value);
                                calendarController.postChosenServices(
                                    widget.chosenServicesToSendDto?.copyWith(
                                      month: value.month,
                                      year: value.year,
                                    ), (value) {
                                  stateController.init(value);
                                });
                              },
                              isLoading:
                                  calendarController.stateManager.isLoading,
                              dates: calendarController.data?.calendar?.dates,
                            );
                          });
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Text(context.loc.show_calendar),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverList.list(
                  children: [
                    Text(
                      context.loc.choose_time_for_services,
                      style: context.textTheme.appTitle,
                    ),
                    const VSpacer(AppDimensions.paddingSmall),
                  ],
                ),
              ),
              Observer(builder: (context) {
                const groupSize = 2;
                const itemWidth = 75.0;
                const itemHeight = 47.5;

                double calculateAspectRatio(
                    double width, double height, int groupSize) {
                  return width / (height * groupSize);
                }

                final double childAspectRatio =
                    calculateAspectRatio(itemWidth, itemHeight, groupSize);

                final combinedSlots = stateController.availableSlots +
                    stateController.disabledSlots;

                combinedSlots.sort((a, b) => a.compareTo(b));

                final groupedDates = DateGroupingService.groupDates(
                  combinedSlots,
                  groupSize: groupSize,
                );

                return SliverPadding(
                  key: _dayChooserListKey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                    // vertical: AppDimensions.paddingMedium,
                  ),
                  sliver: SliverGrid.count(
                    crossAxisCount: 4,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: AppDimensions.paddingMedium,
                    mainAxisSpacing: AppDimensions.paddingMedium,
                    children: groupedDates.map((group) {
                      final widgets = <Widget>[];

                      for (int i = 0; i < group.length; i++) {
                        widgets.add(_buildButton(context, group[i]));

                        if (i < group.length - 1) {
                          widgets.add(_buildDivider(context, group[i]));
                        }
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widgets,
                      );
                    }).toList(),
                  ),
                );
              }),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    context.loc.service_location,
                    style: context.textTheme.appTitle,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  // vertical: AppDimensions.paddingMedium,
                ),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: StyledRadioButton<int>(
                          value: 1,
                          groupValue: stateController.currentServiceLocationId,
                          onTap: (widget.masterInfo?.workingLocationsIds
                                      .contains(1) ??
                                  false)
                              ? (value) {
                                  stateController
                                      .changeCurrentServiceLocationId(value);
                                }
                              : null,
                          title: context.loc.service_locations('in_salon'),
                        ),
                      ),
                      const HSpacer(AppDimensions.paddingMedium),
                      Expanded(
                        child: StyledRadioButton<int>(
                          value: 2,
                          groupValue: stateController.currentServiceLocationId,
                          onTap: (widget.masterInfo?.workingLocationsIds
                                      .contains(2) ??
                                  false)
                              ? (value) {
                                  stateController
                                      .changeCurrentServiceLocationId(value);
                                }
                              : null,
                          title: context.loc.service_locations('away'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: VSpacer(AppDimensions.paddingLarge),
              )
            ],
          );
        }),
      ),
      bottomNavigationBar: ColoredBox(
        color: Theme.of(context).colorScheme.secondary,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingMedium,
              horizontal: AppDimensions.paddingLarge,
            ),
            child: Observer(builder: (context) {
              return ElevatedButton(
                onPressed: stateController.selectedSlots.isEmpty
                    ? null
                    : () {
                        final bookingDto = stateController.handleOnContinue(
                          context,
                          widget.masterInfo?.id,
                        );

                        ShowSnackHelper.showSnack(context, SnackStatus.warning,
                            '${bookingDto?.toJson()}');
                        if (bookingDto == null) {
                          return;
                        }
                        context.pushNamed(
                          ClientRoutes.makeBooking,
                          extra: bookingDto,
                        );
                      },
                child: Text(context.loc.book_now),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class DayChooserList extends StatefulWidget {
  final ValueChanged<DateTime> onChooseDate;
  final DateTime currentDate;
  final List<DateTime> availableDates;

  const DayChooserList({
    super.key,
    required this.onChooseDate,
    required this.currentDate,
    required this.availableDates,
  });

  @override
  State<DayChooserList> createState() => _DayChooserListState();
}

class _DayChooserListState extends State<DayChooserList> {
  late ScrollController _scrollController;

  final itemWidth = 130.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected(0);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelected(int index) {
    const padding = AppDimensions.paddingLarge;

    final screenWidth = MediaQuery.of(context).size.width;
    final targetScrollOffset =
        (index * (itemWidth + AppDimensions.paddingMedium)) -
            (screenWidth / 2 - itemWidth / 2) +
            padding;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final clampedScrollOffset = targetScrollOffset.clamp(0.0, maxScroll);

    _scrollController.jumpTo(clampedScrollOffset);
  }

  @override
  void didUpdateWidget(covariant DayChooserList oldWidget) {
    if (oldWidget.currentDate != widget.currentDate) {
      final index = widget.availableDates.indexOf(widget.currentDate);
      _animateToSelected(index);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _animateToSelected(int index) {
    const padding = AppDimensions.paddingLarge;

    final screenWidth = MediaQuery.of(context).size.width;
    final targetScrollOffset =
        (index * (itemWidth + AppDimensions.paddingMedium)) -
            (screenWidth / 2 - itemWidth / 2) +
            padding;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final clampedScrollOffset = targetScrollOffset.clamp(0.0, maxScroll);

    _scrollController.animateTo(
      clampedScrollOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.availableDates.length,
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
        separatorBuilder: (_, __) {
          return const HSpacer(AppDimensions.paddingMedium);
        },
        itemBuilder: (context, index) {
          final date = widget.availableDates[index];
          final isSelected = widget.currentDate == date;
          void onTap() {
            if (isSelected) {
              return;
            }
            widget.onChooseDate(date);
            _animateToSelected(index);
          }

          return SizedBox(
            width: itemWidth,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('EEEE', context.loc.localeName).format(date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(DateFormat('d MMMM', context.loc.localeName)
                      .format(date)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ServicesTotalInfoWidget extends StatelessWidget {
  final CalendarResponseModel? data;
  const ServicesTotalInfoWidget({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSmall,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  context.loc.total_time,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                ),
                Text('${data?.totals?.totalTime ?? 0} min',
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
            child: VerticalDivider(
              thickness: 1.5,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  context.loc.total_payment,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                ),
                Builder(builder: (context) {
                  final price =
                      '${data?.totals?.totalPriceFix ?? '${data?.totals?.totalPriceMin} - ${data?.totals?.totalPriceMax}'} TMT';
                  return Text(
                    price,
                    style: Theme.of(context).textTheme.titleSmall,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
