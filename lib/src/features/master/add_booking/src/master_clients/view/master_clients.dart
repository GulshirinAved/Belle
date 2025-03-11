import 'package:belle/src/core/core.dart';
import 'package:belle/src/widgets/src/state_control_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../theme/theme.dart';
import '../../../../master.dart';

class MasterBookingClientsScreen extends StatefulWidget {
  final ChosenMasterServicesToSendDto? data;

  const MasterBookingClientsScreen({super.key, required this.data});

  @override
  State<MasterBookingClientsScreen> createState() =>
      _MasterBookingClientsScreenState();
}

class _MasterBookingClientsScreenState
    extends State<MasterBookingClientsScreen> {
  final controller = GetIt.instance<MasterClientsController>();
  final stateController = GetIt.instance<MasterBookingClientsStateController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    controller.setContext(context);
    stateController.setContext(context);
    stateController.initData(widget.data);
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
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Observer(builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingMedium),
            child: ElevatedButton(
              onPressed: stateController.selectedClient == null
                  ? null
                  : () {
                      final data = stateController.handleOnContinue(context);
                      // print(data.time);
                      // return;
                      if (data.time == null) {
                        context.pushNamed(
                          MasterRoutes.masterChooseDate,
                          extra: stateController.data,
                        );
                        return;
                      }

                      context.pushNamed(
                        MasterRoutes.masterCreateBooking,
                        extra: data,
                      );
                    },
              child: Text(
                context.loc.save,
              ),
            ),
          );
        }),
      ),
      body: SafeArea(
        child: RefreshIndicator(
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
                      final needUpdate = await context
                          .pushNamed<bool?>(MasterRoutes.addClient);
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
                if (!(controller.stateManager.isSuccess) ||
                    controller.isEmpty) {
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
                        tileColor:
                            Theme.of(context).colorScheme.surfaceContainer,
                        title: Text(client.contactName ?? ''),
                        subtitle: Text('+993 ${client.contactPhone ?? ''}'),
                        trailing: Observer(builder: (context) {
                          void func() {
                            stateController.changeSelectedClient(client);
                          }

                          if (stateController.selectedClient?.id == client.id) {
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
        ),
      ),
    );
  }
}
