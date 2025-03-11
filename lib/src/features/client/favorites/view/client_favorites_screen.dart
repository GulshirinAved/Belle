import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../../client.dart';

class ClientFavoritesScreen extends StatefulWidget {
  const ClientFavoritesScreen({super.key});

  @override
  State<ClientFavoritesScreen> createState() => _ClientFavoritesScreenState();
}

class _ClientFavoritesScreenState extends State<ClientFavoritesScreen> {
  final servicesController = GetIt.instance<ServicesController>();
  final controller = GetIt.instance<ClientFavoritesController>();
  final stateController = GetIt.instance<ClientFavoritesStateController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final isAccountLoading =
          controller.authStatusController.authLoginStatus ==
              AuthLoginStatus.loading;
      final isAccountError = controller.authStatusController.authLoginStatus ==
          AuthLoginStatus.error;
      if (isAccountLoading || isAccountError) {
        return StateControlWidget(
          props: StateControlWidgetProps(
            isLoading: isAccountLoading,
            isError: isAccountError,
            onError: () {
              final accountController = GetIt.instance<AccountController>();
              accountController.getAccount();
            },
            isSliver: false,
          ),
        );
      }

      if (controller.authStatusController.authLoginStatus ==
          AuthLoginStatus.loggedIn) {
        return Builder(builder: (context) {
          return ClientAuthorizedFavoritesWidgetBody(
            controller: controller,
            servicesController: servicesController,
            stateController: stateController,
          );
        });
      }

      return ClientNonAuthorizedFavoritesWidgetBody(
        onLoginTap: () {
          context.pushNamed(SharedRoutes.login);
        },
        onRegisterTap: () {
          context.pushNamed(SharedRoutes.register);
        },
      );
    });
  }
}

class ClientAuthorizedFavoritesWidgetBody extends StatelessWidget {
  final ClientFavoritesController controller;
  final ClientFavoritesStateController stateController;
  final ServicesController servicesController;

  const ClientAuthorizedFavoritesWidgetBody({
    super.key,
    required this.controller,
    required this.stateController,
    required this.servicesController,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.fetchFavorites();
          return;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(context.loc.favorites),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge),
                child: OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(context.loc.want_to_delete),
                            content: Text(context.loc.want_to_delete),
                            actions: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(context.loc.no),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.deleteAllFavorites();
                                  Navigator.pop(context);
                                },
                                child: Text(context.loc.yes),
                              ),
                            ],
                          );
                        });
                  },
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  icon: const Icon(Icons.close_rounded),
                  label: Text(context.loc.delete_all),
                ),
              ),
            ),
            // SliverPersistentHeader(
            //   pinned: true,
            //   delegate: _SearchHeaderDelegate(
            //     ColoredBox(
            //       color: Theme.of(context).colorScheme.surface,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.stretch,
            //         children: [
            //           Container(
            //             decoration: BoxDecoration(
            //               borderRadius: const BorderRadius.all(
            //                 Radius.circular(AppDimensions.radiusMedium),
            //               ),
            //               color: Theme.of(context).colorScheme.secondary,
            //             ),
            //             padding:
            //                 const EdgeInsets.all(AppDimensions.paddingMedium),
            //             margin: const EdgeInsets.symmetric(
            //               horizontal: AppDimensions.paddingLarge,
            //               vertical: AppDimensions.paddingLarge,
            //             ),
            //             child: const Row(
            //               children: [
            //                 Icon(Icons.search),
            //                 Expanded(
            //                   child: Text('Agadurdy'),
            //                 ),
            //               ],
            //             ),
            //           ),
            //
            //           // VSpacer(AppDimensions.paddingMedium),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Observer(builder: (_) {
              if (!servicesController.stateManager.isSuccess) {
                return StateControlWidget(
                  props: StateControlWidgetProps(
                    isLoading: servicesController.stateManager.isLoading,
                    // isError: servicesController.stateManager.isError,
                    // isEmpty: servicesController.items.isEmpty,
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
                    stateController.changeCurrentServiceId(value);
                  },
                ),
              );
            }),
            Observer(builder: (_) {
              if ((!controller.stateManager.isSuccess) ||
                  (controller.stateManager.isSuccess &&
                      stateController.sortedFavorites.isEmpty)) {
                return StateControlWidget(
                  props: StateControlWidgetProps(
                    isLoading: controller.stateManager.isLoading,
                    isError: servicesController.stateManager.isError,
                    isEmpty: controller.items.isEmpty ||
                        stateController.sortedFavorites.isEmpty ||
                        servicesController.items.isEmpty,
                    onError: () {
                      controller.fetchFavorites();
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
                  childAspectRatio: 160 / 270,
                  children: stateController.sortedFavorites.map((master) {
                    return FavoriteMasterGridCardWidget(
                      master: master,
                      onTap: () {
                        context.pushNamed(
                          ClientRoutes.masterInfo,
                          extra: {'master_id': master.masterId},
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}
//
// class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//
//   _SearchHeaderDelegate(this.child);
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }
//
//   @override
//   double get maxExtent => 130.0;
//
//   @override
//   double get minExtent => 130.0;
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       false;
// }

class FavoriteMasterGridCardWidget extends StatelessWidget {
  final ClientMasterDto master;
  final VoidCallback onTap;

  const FavoriteMasterGridCardWidget(
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
          border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
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
                // height: 210.0 / 1.5,
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
                        master.fullName,
                        style: context.textTheme.containerTitle,
                      ),
                    ),
                    DeleteButton(
                      master: master,
                      favoritesController:
                          GetIt.instance<ClientFavoritesStateController>(),
                    )
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

class DeleteButton extends StatelessWidget {
  final ClientMasterDto master;
  final ClientFavoritesStateController favoritesController;

  const DeleteButton(
      {super.key, required this.favoritesController, required this.master});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () async {
          await favoritesController.handleOnLikeTap(master);
        },
        icon: const Icon(Icons.delete_outline_rounded),
        visualDensity: VisualDensity.comfortable,
        iconSize: 21.0,
        color: Theme.of(context).colorScheme.error,
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          disabledBackgroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.all(AppDimensions.paddingSmall),
          foregroundColor: Theme.of(context).colorScheme.error,
          disabledForegroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    });
  }
}

class ClientNonAuthorizedFavoritesWidgetBody extends StatelessWidget {
  final VoidCallback onRegisterTap;
  final VoidCallback onLoginTap;

  const ClientNonAuthorizedFavoritesWidgetBody({
    super.key,
    required this.onRegisterTap,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Icon(
                Icons.how_to_reg_outlined,
                color: Theme.of(context).colorScheme.error,
                size: 150.0,
              ),
            ),
            const VSpacer(AppDimensions.paddingLarge),
            Center(
              child: Text(
                context.loc.register_to_see_favorites,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const VSpacer(AppDimensions.paddingLarge),
            ElevatedButton(
              onPressed: onRegisterTap,
              child: Text(context.loc.register),
            ),
            const VSpacer(AppDimensions.paddingLarge),
            OutlinedButton(
              onPressed: onLoginTap,
              child: Text(context.loc.login),
            ),
          ],
        ),
      ),
    );
  }
}
