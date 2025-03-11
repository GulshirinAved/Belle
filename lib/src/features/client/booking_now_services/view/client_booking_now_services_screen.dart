import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/widgets.dart';
import '../../client.dart';

class ClientBookingNowServicesScreen extends StatefulWidget {
  final int? id;
  final List<int?> chosenServices;

  const ClientBookingNowServicesScreen({
    super.key,
    required this.id,
    required this.chosenServices,
  });

  @override
  State<ClientBookingNowServicesScreen> createState() =>
      _ClientBookingNowServicesScreenState();
}

class _ClientBookingNowServicesScreenState
    extends State<ClientBookingNowServicesScreen> {
  final infoController = GetIt.instance<ClientBookingNowServicesController>();
  final controller = GetIt.instance<ClientBookingNowServicesStateController>();

  @override
  void initState() {
    infoController.fetchMasterInfo(widget.id ?? 0, () {
      controller.initData(
        infoController.data,
        context,
        widget.chosenServices,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithStyledLeading(
        title: '',
        isSliver: false,
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (!infoController.stateManager.isSuccess) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                isLoading: infoController.stateManager.isLoading,
                isError: infoController.stateManager.isError,
                isEmpty: infoController.items.isEmpty,
                onError: () {
                  infoController.fetchMasterInfo(widget.id ?? 0, () {
                    controller.initData(
                        infoController.data, context, widget.chosenServices);
                  });
                },
                // isSliver: true,
              ),
            );
          }
          final master = controller.data;
          final services = master?.services;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ClientMasterInfoHorizontalCategoriesList(
                  onServiceTap: (value) {
                    controller.changeCurrentSelectedServiceId(value);
                  },
                  services: services,
                  selectedServiceId: controller.selectedServiceId,
                ),
              ),
              ServicesTab(
                onChooseTap: (value) {
                  controller.chooseService(value);
                },
                chosenServices: controller.chosenServices,
                subservices: controller.subservices,
              ),
            ],
          );
        }),
      ),
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
              onPressed: controller.chosenServices.isEmpty
                  ? null
                  : () {
                      controller.handleOnContinue();
                      if (controller.chosenServicesToSendDto == null) {
                        return;
                      }
                      context.pushNamed(
                        ClientRoutes.booking,
                        extra: BookingInfoRouteModel(
                          masterInfo: controller.data,
                          chosenServicesToSendDto:
                              controller.chosenServicesToSendDto,
                        ),
                      );
                      // context.pushNamed(
                      //   ClientRoutes.booking,
                      //   extra: BookingInfoRouteModel(
                      //     masterInfo: controller.data,
                      //     chosenServicesToSendDto: controller.chosenServicesToSendDto,
                      //   ),
                      // );
                    },
              child: Text(
                '${context.loc.choose_date} (${controller.chosenServices.length})',
              ),
            ),
          );
        }),
      ),
    );
  }
}
