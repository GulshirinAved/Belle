import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../theme/theme.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../../../../../widgets/widgets.dart';
import '../../../../../../shared.dart';

class RegisterClientWidget extends StatefulWidget {
  final RegisterClientController controller;

  const RegisterClientWidget({super.key, required this.controller});

  @override
  State<RegisterClientWidget> createState() => _RegisterClientWidgetState();
}

class _RegisterClientWidgetState extends State<RegisterClientWidget>
    with AutomaticKeepAliveClientMixin {
  final key = GlobalKey<FormState>();
  late final RegisterClientController controller;

  @override
  void initState() {
    controller = widget.controller;
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(
          children: [
            StyledBackgroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StandardInputField(
                    props: StandardInputFieldProps(
                      labelText: context.loc.name_surname,
                      textEditingController: controller.nameController,
                      validator: ValidationBuilder(
                        optional: false,
                        localeName: context.loc.localeName,
                      ).build(),
                    ),
                  ),
                  const VSpacer(AppDimensions.paddingExtraLarge),
                  PhoneInputField(
                    props: PhoneInputFieldProps(
                      textEditingController: controller.phoneController,
                    ),
                  ),
                  const VSpacer(AppDimensions.paddingExtraLarge),
                  Text(context.loc.you, style: context.textTheme.appTitle),
                  const VSpacer(AppDimensions.paddingMedium),
                  Observer(builder: (context) {
                    return Row(
                      children: [
                        Expanded(
                          child: StyledRadioButton<int>(
                            value: 1,
                            groupValue: controller.gender,
                            onTap: (value) => controller.toggleGender(value ?? 0),
                            title: context.loc.man,
                          ),
                        ),
                        const HSpacer(AppDimensions.paddingMedium),
                        Expanded(
                          child: StyledRadioButton<int>(
                            value: 2,
                            groupValue: controller.gender,
                            onTap: (value) => controller.toggleGender(value ?? 0),
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
              child: Observer(builder: (context) {
                return AgreementCheckboxWithValidator(
                  agree: controller.agree,
                  onChanged: controller.toggleAgree,
                );
              }),
            ),
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
                        controller.registerClient(
                          () {
                            context.pushNamed(
                              SharedRoutes.registerClientOtp,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
