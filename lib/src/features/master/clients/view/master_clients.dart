import 'package:belle/src/core/core.dart';
import 'package:belle/src/widgets/src/state_control_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/theme.dart';
import '../../master.dart';

class MasterClientsScreen extends StatefulWidget {
  const MasterClientsScreen({super.key});

  @override
  State<MasterClientsScreen> createState() => _MasterClientsScreenState();
}

class _MasterClientsScreenState extends State<MasterClientsScreen> {
  final controller = GetIt.instance<MasterClientsController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    controller.setContext(context);
    controller.fetchClients();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        controller.fetchMoreClients();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.disposeContext();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return await controller.fetchClients();
      },
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(context.loc.clients),
            actions: [
              OutlinedButton.icon(
                onPressed: () async {
                  final needUpdate =
                      await context.pushNamed<bool?>(MasterRoutes.addClient);
                  if (needUpdate == null) {
                    return;
                  }
                  if (needUpdate) {
                    controller.fetchClients();
                  }
                },
                style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(Icons.add),
                label: Text(context.loc.add_new_client),
              ),
            ],
          ),
          Observer(builder: (context) {
            if (!(controller.stateManager.isSuccess) || controller.isEmpty) {
              return StateControlWidget(
                props: StateControlWidgetProps(
                  isEmpty: controller.isEmpty,
                  isLoading: controller.stateManager.isLoading,
                  isError: controller.stateManager.isError,
                  isSliver: true,
                  onError: () {
                    controller.fetchClients();
                  },
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  final client = controller.items[index];
                  return ListTile(
                    onTap: () async {
                      final needUpdate = await context.pushNamed<bool?>(
                          MasterRoutes.clientInfo,
                          extra: client);

                      if (needUpdate == null) {
                        return;
                      }
                      if (needUpdate) {
                        controller.fetchClients();
                      }
                    },
                    tileColor: Theme.of(context).colorScheme.surfaceContainer,
                    title: Text(client.contactName ?? ''),
                    subtitle: Text('+993 ${client.contactPhone ?? ''}'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  );
                },
                separatorBuilder: (_, __) {
                  return const Divider(height: 0.0);
                },
                itemCount: controller.items.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}
