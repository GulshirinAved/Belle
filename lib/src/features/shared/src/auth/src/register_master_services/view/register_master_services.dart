import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../theme/theme.dart';
import '../../../../../../../widgets/widgets.dart';

class RegisterMasterServicesScreen extends StatefulWidget {
  const RegisterMasterServicesScreen({super.key});

  @override
  State<RegisterMasterServicesScreen> createState() =>
      _RegisterMasterServicesScreenState();
}

class _RegisterMasterServicesScreenState
    extends State<RegisterMasterServicesScreen> {
  final controller = GetIt.instance<RegisterMasterServicesController>();
  final stateController =
      GetIt.instance<RegisterMasterServicesStateController>();

  @override
  void initState() {
    controller.setContext(context);
    controller.init(stateController.currentMasterType.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.main_profile),
        leadingWidth: 80.0,
        leading: StyledBackButton(
          onTap: () {
            context.pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingMedium,
            ),
            child: Observer(builder: (context) {
              return AnimatedToggleWidget<MasterType>(
                initialValue: stateController.currentMasterType,
                onChanged: (value) {
                  if (controller.stateManager.isLoading) {
                    return;
                  }
                  stateController.setMasterType(value);
                  controller.init(stateController.currentMasterType.id);
                },
                props: AnimatedToggleWidgetProps<MasterType>(
                  selectedValue: stateController.currentMasterType,
                ),
                items: [
                  AnimatedToggleWidgetItem(
                    value: MasterType.men,
                    title: context.loc.for_men,
                  ),
                  AnimatedToggleWidgetItem(
                    value: MasterType.women,
                    title: context.loc.for_women,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          if (!controller.stateManager.isSuccess) {
            return StateControlWidget(
              props: StateControlWidgetProps(
                // isSliver: true,
                isLoading: controller.stateManager.isLoading,
                isError: controller.stateManager.isError,
                onError: () {
                  controller.init(stateController.currentMasterType.id);
                },
              ),
            );
          }
          return SingleChildScrollView(
            child: StyledBackgroundContainer(
              child: Column(
                spacing: AppDimensions.paddingLarge,
                children: [
                  StyledContainerWithColumn(
                    items: (controller.items).map((service) {
                      return DualToneContainer(
                        index: controller.items.indexOf(service),
                        length: controller.items.length,
                        child: RadioListTile(
                          value: service,
                          groupValue: stateController.serviceDto,
                          dense: true,
                          visualDensity: VisualDensity.compact,
                          title: Text(service.name ?? ''),
                          onChanged: (value) {
                            stateController
                                .changeSelectedService(value ?? service);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimensions.radiusMedium),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingMedium,
                      horizontal: AppDimensions.paddingLarge,
                    ),
                    child: Column(
                      spacing: AppDimensions.paddingSmall,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          context.loc.did_not_find,
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                        Text(context.loc.register_to_suggest_service,
                          textAlign: TextAlign.center,

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: SafeArea(
        child: StyledBackgroundContainer(
          child: Observer(builder: (context) {
            return ElevatedButtonWithState(
              isLoading: controller.stateManager.isLoading,
              onPressed: stateController.serviceDto == null
                  ? null
                  : () {
                      if (stateController.serviceDto == null) {
                        return;
                      }
                      context.pop(stateController.serviceDto);
                    },
              child: Text(context.loc.save),
            );
          }),
        ),
      ),
    );
  }
}
