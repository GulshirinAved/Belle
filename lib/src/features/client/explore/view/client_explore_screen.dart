import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../../client.dart';

class ClientExploreScreen extends StatefulWidget {
  const ClientExploreScreen({super.key});

  @override
  State<ClientExploreScreen> createState() => _ClientExploreScreenState();
}

class _ClientExploreScreenState extends State<ClientExploreScreen> {
  final controller = GetIt.instance<ClientExploreController>();
  final searchController = GetIt.instance<ClientExploreSearchController>();
  final servicesController = GetIt.instance<ServicesController>();
  final _scrollController = ScrollController();

  void addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent *
              controller.offsetPaginationBoundary) {
        controller.fetchMastersPagination();
      }
    });
  }

  @override
  void initState() {
    controller.setContext(context);
    controller.init();
    if (servicesController.stateManager.isSuccess) {
      controller.fetchMasters();
    }
    addScrollListener();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final masterTypeController = GetIt.instance<MasterTypeController>();
        return await servicesController
            .fetchServices(masterTypeController.currentMasterType.id);
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeaderDelegate(
              ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: ClientExploreSearch(searchController),
                          useRootNavigator: true,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppDimensions.radiusMedium)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        padding:
                            const EdgeInsets.all(AppDimensions.paddingMedium),
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge,
                          vertical: AppDimensions.paddingLarge,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            Expanded(
                              child: Text(context.loc.search),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge),
                      child: Row(
                        children: [
                          Flexible(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  useRootNavigator: true,
                                  useSafeArea: true,
                                  builder: (context) {
                                    return ClientExploreSortBottomSheetBody(
                                      onSortChanged: (value) {
                                        controller.updateParams(value);
                                        controller.fetchMasters();
                                      },
                                      sortParams: controller.sortParams,
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                visualDensity: VisualDensity.compact,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        AppDimensions.radiusExtraLarge),
                                  ),
                                ),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                              icon: const Icon(Icons.sort),
                              label: Text(context.loc.sort),
                            ),
                          ),
                          const HSpacer(AppDimensions.paddingMedium),
                          Flexible(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                controller.updateParams(null);
                                controller.fetchMasters();
                              },
                              style: OutlinedButton.styleFrom(
                                visualDensity: VisualDensity.compact,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        AppDimensions.radiusExtraLarge),
                                  ),
                                ),
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              icon: const Icon(Icons.close_rounded),
                              label: Text(context.loc.reset),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // VSpacer(AppDimensions.paddingMedium),
                  ],
                ),
              ),
            ),
          ),
          Observer(builder: (_) {
            if (!servicesController.stateManager.isSuccess) {
              return StateControlWidget(
                props: StateControlWidgetProps(
                  isLoading: servicesController.stateManager.isLoading,
                  onError: () {
                    servicesController.fetchServices();
                  },
                  isSliver: true,
                ),
              );
            }
            return SliverToBoxAdapter(
              child: HorizontalCategoriesList(
                services: servicesController.items,
                onTap: (value) {
                  controller.fetchMasters(value);
                },
              ),
            );
          }),
          Observer(builder: (context) {
            if (!controller.stateManager.isSuccess) {
              return StateControlWidget(
                props: StateControlWidgetProps(
                  isLoading: controller.stateManager.isLoading,
                  isError: controller.stateManager.isError,
                  isEmpty: controller.items.isEmpty,
                  onError: () {
                    controller.fetchMasters();
                  },
                  isSliver: true,
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                // vertical: AppDimensions.paddingLarge,
              ),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: AppDimensions.paddingMedium,
                crossAxisSpacing: AppDimensions.paddingMedium,
                childAspectRatio: 160 / 250,
                children: controller.items
                    .map(
                      (value) => MasterGridCardWithBookNowWidget(
                        master: value,
                        onTap: () {
                          context.pushNamed(
                            ClientRoutes.masterInfo,
                            extra: {'master_id': value.masterId},
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          }),
          SliverToBoxAdapter(
            child: Observer(builder: (_) {
              if (controller.stateManager.isPaginationLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingExtraLarge * 2,
                  ),
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
              return const SizedBox();
            }),
          ),
        ],
      ),
    );
  }
}

class ClientExploreSortBottomSheetBody extends StatefulWidget {
  final ValueChanged<ClientMastersSortParams?> onSortChanged;
  final ClientMastersSortParams? sortParams;

  const ClientExploreSortBottomSheetBody({
    super.key,
    required this.onSortChanged,
    required this.sortParams,
  });

  @override
  State<ClientExploreSortBottomSheetBody> createState() =>
      _ClientExploreSortBottomSheetBodyState();
}

class _ClientExploreSortBottomSheetBodyState
    extends State<ClientExploreSortBottomSheetBody> {
  ClientMastersSortParams? sortParams;

  @override
  void initState() {
    sortParams = widget.sortParams;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RadioListTile(
                      value: const ClientMastersSortParams(
                          ClientMastersOrderBy.asc, ClientMastersSortBy.rating),
                      groupValue: sortParams,
                      visualDensity: VisualDensity.compact,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingExtraSmall,
                      ),
                      dense: true,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                          context.loc.sort_by(context.loc.by_rating, 'asc')),
                      onChanged: (value) {
                        sortParams = value;
                        setState(() {});
                      },
                    ),
                    RadioListTile(
                      value: const ClientMastersSortParams(
                          ClientMastersOrderBy.desc,
                          ClientMastersSortBy.rating),
                      groupValue: sortParams,
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.paddingExtraSmall,
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text(
                          context.loc.sort_by(context.loc.by_rating, 'desc')),
                      onChanged: (value) {
                        sortParams = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                widget.onSortChanged(sortParams);
                Navigator.pop(context);
              },
              child: Text(context.loc.apply),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalCategoriesList extends StatefulWidget {
  final List<ClientServiceDto> services;
  final ValueChanged<int?> onTap;
  final int? currentSelectedId;

  const HorizontalCategoriesList({
    super.key,
    required this.services,
    required this.onTap,
    this.currentSelectedId,
  });

  @override
  State<HorizontalCategoriesList> createState() =>
      _HorizontalCategoriesListState();
}

class _HorizontalCategoriesListState extends State<HorizontalCategoriesList> {
  int currentIndex = 0;

  @override
  void initState() {
    if (widget.currentSelectedId != null) {
      currentIndex =
          widget.services.indexWhere((el) => el.id == widget.currentSelectedId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.services.length,
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
        separatorBuilder: (_, __) {
          return const HSpacer(AppDimensions.paddingMedium);
        },
        itemBuilder: (context, index) {
          final isSelected = currentIndex == index;
          final item = widget.services[index];
          return GestureDetector(
            onTap: () {
              if (isSelected) {
                return;
              }
              widget.onTap(item.id);
              setState(() {
                currentIndex = index;
              });
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
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CachingSVGImage(
                      item.iconPath ?? '',
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const HSpacer(AppDimensions.paddingSmall),
                  Text(item.name ?? '',
                      style: context.textTheme.containerTitle),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchHeaderDelegate(this.child);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 130.0;

  @override
  double get minExtent => 130.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class MasterGridCardWithBookNowWidget extends StatelessWidget {
  final ClientMasterDto master;
  final VoidCallback onTap;

  const MasterGridCardWithBookNowWidget({
    super.key,
    required this.master,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      elevation: 0.0,
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.radiusLarge),
          ),
          color: colorScheme.secondary,
          border: Border.all(color: colorScheme.onSurface),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.radiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppDimensions.radiusLarge),
                      ),
                      child: CachingImage(master.image),
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
                color: colorScheme.onSurface,
              ),
              const VSpacer(AppDimensions.paddingExtraSmall),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const HSpacer(AppDimensions.paddingSmall),
                    Expanded(
                      child: Text(
                        master.fullName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      ClientRoutes.bookingNowServices,
                      extra: MasterServicesRouteModel(
                        masterId: master.masterId?.toInt(),
                        chosenServices: const [],
                      ),
                    );
                  },
                  child: Text(context.loc.book_now),
                ),
              ),
              const VSpacer(AppDimensions.paddingMedium),
            ],
          ),
        ),
      ),
    );
  }
}
