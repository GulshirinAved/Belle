import 'dart:developer';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/language/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';
import '../../client.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final carouselController = CarouselController();
  final themeController = GetIt.instance<ThemeController>();
  final homeController = GetIt.instance<ClientHomeController>();
  final servicesController = GetIt.instance<ServicesController>();
  final masterTypeController = GetIt.instance<MasterTypeController>();

  @override
  void initState() {
    homeController.newMastersController.setContext(context);
    homeController.topStylistsController.setContext(context);
    homeController.init();
    homeController.loadAllData(masterTypeController.currentMasterType.id);
    super.initState();
  }

  @override
  void dispose() {
    homeController.newMastersController.disposeContext();
    homeController.topStylistsController.disposeContext();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarLogoComponent(),
        // pinned: true,
        actions: const [
          // ThemeChooseButton(),
          NotificationsButton(),
          LanguageChooseButton(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingMedium),
            child: Observer(builder: (context) {
              return AnimatedToggleWidget<MasterType?>(
                initialValue: masterTypeController.currentMasterType,
                onChanged: (value) {
                  masterTypeController.setMasterType(value ?? MasterType.women);
                },
                props: const AnimatedToggleWidgetProps(),
                items: [
                  AnimatedToggleWidgetItem(
                      value: MasterType.women, title: context.loc.for_women),
                  AnimatedToggleWidgetItem(
                      value: MasterType.men, title: context.loc.for_men),
                ],
              );
            }),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final masterTypeController = GetIt.instance<MasterTypeController>();
          return await homeController
              .loadAllData(masterTypeController.currentMasterType.id);
        },
        child: Observer(builder: (context) {
          if (!homeController.isSuccess) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                // isSliver: true,
                isLoading: homeController.isLoading ||
                    servicesController.stateManager.isLoading,
                isError: homeController.isError ||
                    servicesController.stateManager.isError,
                onError: () {
                  final masterTypeController =
                      GetIt.instance<MasterTypeController>();
                  servicesController
                      .fetchServices(masterTypeController.currentMasterType.id);
                  homeController
                      .loadAllData(masterTypeController.currentMasterType.id);
                },
              ),
            );
          }
          final topStylists = homeController.topStylistsController.items;
          final newMasters = homeController.newMastersController.items;
          return CustomScrollView(
            slivers: [
              const VSpacer(
                AppDimensions.paddingMedium,
                isSliver: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingLarge,
                ),
                sliver: TitleWithButton(
                  title: context.loc.top_rated_stylist,
                  onTap: () {
                    context.pushNamed(ClientRoutes.topStylists);
                  },
                  isSliver: true,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                ),
                sliver: SliverToBoxAdapter(
                  child: CarouselWithIndicators(
                    carouselItems: topStylists.map((value) {
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            ClientRoutes.masterInfo,
                            extra: {'master_id': value.masterId},
                          );
                        },
                        child: CarouselBannerItem(
                          masterDto: value,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingLarge,
                ),
                sliver: TitleWithButton(
                  title: context.loc.new_masters,
                  onTap: () {
                    context.pushNamed(ClientRoutes.newMasters);
                  },
                  isSliver: true,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                ),
                sliver: SliverToBoxAdapter(
                  child: CarouselWithDynamicLayout<ClientMasterDto>(
                    items: newMasters,
                    itemsPerPage: 2,
                    itemBuilder: (context, item) => MasterGridCardWidget(
                      master: item,
                      onTap: () {
                        context.pushNamed(
                          ClientRoutes.masterInfo,
                          extra: {'master_id': item.masterId},
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge,
                  vertical: AppDimensions.paddingLarge,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    context.loc.explore_services,
                    style: context.textTheme.appTitle,
                  ),
                ),
              ),
              Observer(builder: (context) {
                if (!servicesController.stateManager.isSuccess) {
                  return StateControlWidget(
                    props: StateControlWidgetProps(
                      isSliver: true,
                      isLoading: servicesController.stateManager.isLoading,
                      isError: servicesController.stateManager.isError,
                      onError: () {
                        servicesController.fetchServices();
                      },
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                    // vertical: AppDimensions.paddingLarge,
                  ),
                  sliver: SliverGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: AppDimensions.paddingMedium,
                    crossAxisSpacing: AppDimensions.paddingMedium,
                    children: servicesController.items.map((el) {
                      return HomeServiceWidget(
                        clientServiceDto: el,
                        onTap: () {
                          context.pushNamed(
                            ClientRoutes.mastersByService,
                            extra: ClientServiceRouteModel(el.id, el.name),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              }),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppDimensions.paddingMedium),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pushNamed(ClientRoutes.notifications);
      },
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      icon: const Icon(Icons.notifications_none_rounded),
    );
  }
}

class ThemeChooseButton extends StatefulWidget {
  const ThemeChooseButton({super.key});

  @override
  State<ThemeChooseButton> createState() => _ThemeChooseButtonState();
}

class _ThemeChooseButtonState extends State<ThemeChooseButton> {
  final themeController = GetIt.instance<ThemeController>();

  IconData _getIcon(ThemeMode mode) {
    final isDarkTheme = mode == ThemeMode.dark;
    final isAutoModeTheme = mode == ThemeMode.system;

    if (isDarkTheme) {
      return Icons.dark_mode_outlined;
    }
    if (isAutoModeTheme) {
      return Icons.hdr_auto_outlined;
    }
    return Icons.light_mode_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return IconButton(
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.loc.choose_theme,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: AppFonts.onest,
                            fontSize: 16.0,
                          ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...ThemeMode.values.map((el) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppDimensions.paddingExtraSmall),
                          child: Builder(builder: (context) {
                            if (el == themeController.themeMode) {
                              return ElevatedButton.icon(
                                onPressed: () {},
                                label: Text(el.name),
                                icon: Icon(_getIcon(el)),
                              );
                            }
                            return OutlinedButton.icon(
                              onPressed: () {
                                themeController.updateThemeMode(el);
                              },
                              label: Text(el.name),
                              icon: Icon(_getIcon(el)),
                            );
                          }),
                        );
                      }),
                    ]),
              );
            },
          );
        },
        icon: Icon(_getIcon(themeController.themeMode)),
      );
    });
  }
}

class MasterGridCardWidget extends StatelessWidget {
  final ClientMasterDto master;
  final VoidCallback onTap;

  const MasterGridCardWidget(
      {super.key, required this.master, required this.onTap});

  String _calculateCategoriesTitle(
      BuildContext context, List<String>? categories) {
    if (categories == null || categories.isEmpty) {
      return context.loc.no_categories;
    }
    if (categories.length == 1) {
      return categories.first;
    }
    return '${categories.first} +${(categories.length) - 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.radiusLarge),
          ),
          color: Theme.of(context).colorScheme.secondary,
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.radiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                // height: 210.0 / 1.5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppDimensions.radiusLarge),
                      ),
                      child: CachingImage(
                        master.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppDimensions.paddingSmall),
                        child: RatingWidgetWithTitle(
                          rating: master.avgRating,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.3,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const VSpacer(AppDimensions.paddingExtraSmall),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const HSpacer(AppDimensions.paddingSmall),
                    Expanded(
                      child: Text(
                        '${master.personFn ?? ''} ${master.personLn ?? ''}',
                        style: context.textTheme.containerTitle,
                      ),
                    ),
                    LikeButton(
                      master: master,
                      favoritesController:
                          GetIt.instance<ClientFavoritesStateController>(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSmall,
                ),
                child: Text(
                  _calculateCategoriesTitle(
                      context, [master.profileName ?? '']),
                ),
              ),
              const VSpacer(AppDimensions.paddingSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  final ClientMasterDto master;
  final ClientFavoritesStateController favoritesController;

  const LikeButton({
    super.key,
    required this.master,
    required this.favoritesController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Observer(builder: (context) {
      final isFavorite = favoritesController.isFavorite(master.masterId);

      return IconButton(
        onPressed: favoritesController.syncLoading
            ? null
            : () async {
                await favoritesController.handleOnLikeTap(master);
              },
        selectedIcon: Icon(
          Icons.favorite_rounded,
          color: colorScheme.error,
        ),
        icon: Icon(
          Icons.favorite_border_rounded,
          color: colorScheme.error,
        ),
        visualDensity: VisualDensity.comfortable,
        iconSize: 21.0,
        isSelected: isFavorite,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.fullWhite,
          padding: const EdgeInsets.all(AppDimensions.paddingSmall),
          disabledBackgroundColor: AppColors.fullWhite,
        ),
      );
    });
  }
}

class HomeServiceWidget extends StatelessWidget {
  final ClientServiceDto clientServiceDto;
  final VoidCallback onTap;

  const HomeServiceWidget({
    super.key,
    required this.clientServiceDto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(AppDimensions.radiusMedium)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.0,
              width: 40.0,
              child: CachingSVGImage(clientServiceDto.iconPath),
            ),
            const VSpacer(AppDimensions.paddingSmall),
            Flexible(
              child: Text(
                clientServiceDto.name ?? '',
                style: context.textTheme.containerTitle,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselBannerItem extends StatelessWidget {
  final ClientMasterDto masterDto;

  const CarouselBannerItem({super.key, required this.masterDto});

  @override
  Widget build(BuildContext context) {
    log('it is image :${masterDto.image.toString()}');

    return Stack(
      fit: StackFit.expand,
      children: [
        CachingImage(
          masterDto.image,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingSmall),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: RatingWidgetWithTitle(
                  rating: masterDto.avgRating ?? 0.0,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppDimensions.radiusLarge),
                    ),
                    color:
                        Theme.of(context).colorScheme.secondary.withAlpha(150),
                  ),
                  padding: const EdgeInsets.all(
                    AppDimensions.paddingMedium,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${masterDto.personFn ?? ''} ${masterDto.personLn ?? ''}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                      Text(context.loc.profile),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RatingWidgetWithTitle extends StatelessWidget {
  final num? rating;

  const RatingWidgetWithTitle({super.key, this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.radiusLarge),
        ),
        color: Theme.of(context).colorScheme.secondary.withAlpha(120),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.star_rounded,
            color: AppColors.yellow,
            size: 16.0,
          ),
          const HSpacer(AppDimensions.paddingExtraSmall),
          Text(
            '${rating ?? 0.0}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class TitleWithButton extends StatelessWidget {
  final String title;
  final String? buttonTitle;
  final VoidCallback onTap;
  final bool isSliver;

  const TitleWithButton({
    super.key,
    required this.title,
    required this.onTap,
    this.buttonTitle,
    this.isSliver = false,
  });

  @override
  Widget build(BuildContext context) {
    final contentWidget = Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: context.textTheme.appTitle,
          ),
        ),
        ElevatedButton.icon(
          onPressed: onTap,
          label: Text(buttonTitle ?? context.loc.see_all),
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.0,
            color: AppColors.fullWhite,
          ),
          iconAlignment: IconAlignment.end,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingSmall,
              horizontal: AppDimensions.paddingLarge,
            ),
          ),
        )
      ],
    );
    if (isSliver) {
      return SliverToBoxAdapter(
        child: contentWidget,
      );
    }
    return contentWidget;
  }
}

enum MasterType {
  men(1),
  women(2),
  def(0);

  final int id;

  const MasterType(this.id);
}

class CarouselWithIndicators extends StatefulWidget {
  final List<Widget> carouselItems;

  const CarouselWithIndicators({super.key, required this.carouselItems});

  @override
  State<CarouselWithIndicators> createState() => _CarouselWithIndicatorsState();
}

class _CarouselWithIndicatorsState extends State<CarouselWithIndicators> {
  final PageController _carouselController = PageController(initialPage: 1000);
  int _currentIndex = 0;

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.carouselItems.isNotEmpty) {
      return Column(
        children: [
          SizedBox(
            height: 160.0,
            child: PageView.builder(
              controller: _carouselController,
              onPageChanged: (page) {
                setState(() {
                  _currentIndex = page % widget.carouselItems.length;
                });
              },
              itemBuilder: (context, index) {
                final realIndex = index % widget.carouselItems.length;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: widget.carouselItems[realIndex],
                );
              },
            ),
          ),
          const VSpacer(AppDimensions.paddingMedium),
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: AppDimensions.paddingSmall,
            children: List.generate(
              widget.carouselItems.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSmall / 2),
                width: 12.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 0.35,
                  ),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class CarouselWithStackIndicators extends StatefulWidget {
  final List<Widget> carouselItems;
  final double? height;

  const CarouselWithStackIndicators(
      {super.key, required this.carouselItems, this.height});

  @override
  State<CarouselWithStackIndicators> createState() =>
      _CarouselWithStackIndicatorsState();
}

class _CarouselWithStackIndicatorsState
    extends State<CarouselWithStackIndicators> {
  final PageController _carouselController = PageController(initialPage: 0);
  int _currentIndex = 0;
  late final List<Widget> carouselItems;

  @override
  void initState() {
    carouselItems = (widget.carouselItems.isEmpty
        ? [const CachingImage('')]
        : widget.carouselItems);
    super.initState();
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.height ?? 160.0,
          child: PageView.builder(
            controller: _carouselController,
            onPageChanged: (page) {
              setState(() {
                _currentIndex =
                    page % (carouselItems.isEmpty ? 1 : carouselItems.length);
              });
            },
            itemBuilder: (context, index) {
              final realIndex =
                  index % (carouselItems.isEmpty ? 1 : carouselItems.length);
              return carouselItems[realIndex];
            },
          ),
        ),
        const VSpacer(AppDimensions.paddingMedium),
        Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: AppDimensions.paddingSmall,
            children: List.generate(
              carouselItems.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSmall / 2),
                width: 12.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 0.35,
                  ),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CarouselWithDynamicLayout<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final int itemsPerPage;
  final double itemSpacing;
  final double height;

  const CarouselWithDynamicLayout({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.itemsPerPage,
    this.itemSpacing = AppDimensions.paddingSmall,
    this.height = 210.0,
  });

  @override
  State<CarouselWithDynamicLayout<T>> createState() =>
      _CarouselWithDynamicLayoutState<T>();
}

class _CarouselWithDynamicLayoutState<T>
    extends State<CarouselWithDynamicLayout<T>> {
  final PageController _pageController = PageController(initialPage: 0);
  late final int pageCount;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageCount = (widget.items.length / widget.itemsPerPage).ceil();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentIndex = page % pageCount;
              });
            },
            itemCount: pageCount,
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * widget.itemsPerPage;
              final endIndex = (startIndex + widget.itemsPerPage)
                  .clamp(0, widget.items.length);

              final pageItems = widget.items.sublist(startIndex, endIndex);

              final paddedItems = [
                ...pageItems,
                ...List.generate(
                  widget.itemsPerPage - pageItems.length,
                  (_) => null,
                )
              ];

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: paddedItems.map((item) {
                  if (item == null) {
                    return Expanded(
                      child: SizedBox(width: widget.itemSpacing),
                    );
                  } else {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.itemSpacing / 2),
                        child: widget.itemBuilder(context, item),
                      ),
                    );
                  }
                }).toList(),
              );
            },
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 8.0,
          children: List.generate(
            pageCount,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: 12.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary,
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 0.35,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarLogoComponent extends StatelessWidget {
  const AppBarLogoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppAssets.appLogo, height: 50.0, width: 100.0);
  }
}
