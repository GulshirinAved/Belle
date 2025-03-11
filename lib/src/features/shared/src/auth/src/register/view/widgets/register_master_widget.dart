import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../theme/theme.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../../../../../widgets/widgets.dart';
import '../../../../../../../client/client.dart';
import '../../../../../../shared.dart';

class RegisterMasterWidget extends StatefulWidget {
  final RegisterMasterController controller;
  final ServicesController servicesController;

  const RegisterMasterWidget({
    super.key,
    required this.controller,
    required this.servicesController,
  });

  @override
  State<RegisterMasterWidget> createState() => _RegisterMasterWidgetState();
}

class _RegisterMasterWidgetState extends State<RegisterMasterWidget>
    with AutomaticKeepAliveClientMixin {
  final key = GlobalKey<FormState>();

  late final RegisterMasterController controller;
  late final ServicesController servicesController;

  @override
  void initState() {
    controller = widget.controller;
    servicesController = widget.servicesController;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    key.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: key,
      // autovalidateMode: AutovalidateMode.onUnfocus,
      child: ListView(
        children: [
          StyledBackgroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppDimensions.paddingExtraLarge,
              children: [
                PhoneInputField(
                  props: PhoneInputFieldProps(
                    textEditingController: controller.phoneController,
                  ),
                ),
                StandardInputField(
                  props: StandardInputFieldProps(
                    labelText: context.loc.first_name,
                    textEditingController: controller.firstNameController,
                    validator: ValidationBuilder(
                      optional: false,
                      localeName: context.loc.localeName,
                    ).build(),
                  ),
                ),
                StandardInputField(
                  props: StandardInputFieldProps(
                    labelText: context.loc.last_name,
                    textEditingController: controller.lastNameController,
                    validator: ValidationBuilder(
                      optional: false,
                      localeName: context.loc.localeName,
                    ).build(),
                  ),
                ),
                PasswordInputField(
                  props: PasswordInputFieldProps(
                    textEditingController: controller.passwordController,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final service = await context.pushNamed<ClientServiceDto?>(SharedRoutes.registerMasterServices);
                    if(service == null) {
                      return;
                    }
                    controller.changeSelectedService(service);
                  },
                  child: Observer(
                    builder: (context) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: context.loc.main_profile,
                          suffixIcon: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        isEmpty: controller.selectedService == null,
                        child: Text(controller.selectedService?.name ?? ''),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
          const VSpacer(AppDimensions.paddingMedium),
          StyledBackgroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.loc.you, style: context.textTheme.appTitle),
                const VSpacer(AppDimensions.paddingMedium),
                Observer(builder: (context) {
                  return Row(
                    children: [
                      Expanded(
                        child: StyledRadioButton<int>(
                          value: 1,
                          groupValue: controller.gender,
                          onTap: (value) => controller.toggleGender(value ?? 1),
                          title: context.loc.man,
                        ),
                      ),
                      const HSpacer(AppDimensions.paddingMedium),
                      Expanded(
                        child: StyledRadioButton<int>(
                          value: 2,
                          groupValue: controller.gender,
                          onTap: (value) => controller.toggleGender(value ?? 2),
                          title: context.loc.woman,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const VSpacer(AppDimensions.paddingMedium),
          StyledBackgroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.loc.service_location,
                  style: context.textTheme.appTitle,
                ),
                const VSpacer(AppDimensions.paddingMedium),
                Observer(builder: (context) {
                  return Wrap(
                    spacing: AppDimensions.paddingMedium,
                    children: controller.workingLocations.map((location) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width / 2 -
                              (AppDimensions.paddingMedium * 2),
                          maxWidth: MediaQuery.of(context).size.width / 2 -
                              (AppDimensions.paddingMedium * 2),
                        ),
                        child: StyledCheckbox(
                          value: controller.selectedWorkingLocations.contains(
                            location.id,
                          ),
                          onChanged: (_) => controller
                              .toggleSelectedWorkingLocation(location.id),
                          title: context.loc.service_locations(location.title),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
          const VSpacer(AppDimensions.paddingMedium),
          Observer(builder: (context) {
            return StyledBackgroundContainer(
              child: AgreementCheckboxWithValidator(
                agree: controller.agree,
                onChanged: controller.toggleAgree,
              ),
            );
          }),
          const VSpacer(AppDimensions.paddingMedium),
          StyledBackgroundContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Observer(builder: (context) {
                  return ElevatedButtonWithState(
                    onPressed: () {
                      if (!controller.validateForm(key)) {
                        return;
                      }
                      controller.registerMaster(
                        () {
                          context.pushNamed(
                            SharedRoutes.registerMasterOtp,
                            extra: controller.generateRegisterModel(),
                          );
                        },
                      );
                    },
                    isLoading: controller.isLoading,
                    child: Text(context.loc.send_code),
                  );
                }),
                const VSpacer(AppDimensions.paddingLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.loc.already_user),
                    const HSpacer(AppDimensions.paddingSmall),
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.isLoading) {
                            return;
                          }
                          context.pushNamed(SharedRoutes.login);
                        },
                        child: Text(
                          context.loc.login,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
