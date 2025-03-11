import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../../client.dart';

class ClientMastersByServiceScreen extends StatefulWidget {
  final int? serviceId;
  final String? serviceName;
  const ClientMastersByServiceScreen({super.key, this.serviceId, this.serviceName});

  @override
  State<ClientMastersByServiceScreen> createState() => _ClientMastersByServiceScreenState();
}

class _ClientMastersByServiceScreenState extends State<ClientMastersByServiceScreen> {
  final controller = GetIt.instance<ClientMastersByServiceController>();
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
    controller.setupParams(widget.serviceId);
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
        title: widget.serviceName ?? '',
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
