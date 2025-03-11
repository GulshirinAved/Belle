import 'package:belle/src/features/client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';

class ClientTopStylistsScreen extends StatefulWidget {
  const ClientTopStylistsScreen({super.key});

  @override
  State<ClientTopStylistsScreen> createState() =>
      _ClientTopStylistsScreenState();
}

class _ClientTopStylistsScreenState extends State<ClientTopStylistsScreen> {
  final controller = GetIt.instance<ClientTopStylistsController>();
  final servicesController = GetIt.instance<ServicesController>();

  final _scrollController = ScrollController();

  void addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent *
              controller.offsetPaginationBoundary) {
        controller.fetchMoreMasters();
      }
    });
  }


  @override
  void initState() {
    controller.setContext(context);
    controller.setupParams();
    controller.fetchMasters();
    addScrollListener();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.disposeContext();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithStyledLeading(
        title: context.loc.top_rated_stylist,
        isSliver: false,
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await controller.fetchMasters();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: HorizontalCategoriesList(
                  services: servicesController.items,
                  onTap: (value) {
                    controller.fetchMasters(value);
                  },
                ),
              ),
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
                          vertical: AppDimensions.paddingLarge),
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
        ),
      ),
    );
  }
}
