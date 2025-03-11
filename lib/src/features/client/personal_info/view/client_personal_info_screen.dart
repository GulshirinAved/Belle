import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:belle/src/theme/theme.dart';
import 'package:belle/src/utils/src/form_validator/form_validator.dart';
import 'package:belle/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../client.dart';

class ClientPersonalInfoScreen extends StatefulWidget {
  const ClientPersonalInfoScreen({super.key});

  @override
  State<ClientPersonalInfoScreen> createState() =>
      _ClientPersonalInfoScreenState();
}

class _ClientPersonalInfoScreenState extends State<ClientPersonalInfoScreen> {
  final accountController = GetIt.instance<AccountController>();
  final controller = GetIt.instance<ClientPersonalInfoController>();

  final key = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController emailController;

  @override
  void initState() {
    nameController =
        TextEditingController(text: accountController.accountInfo?.fullName);
    phoneController =
        TextEditingController(text: accountController.accountInfo?.phone);
    addressController =
        TextEditingController(text: accountController.accountInfo?.address);
    emailController =
        TextEditingController(text: accountController.accountInfo?.email);
    super.initState();
  }

  @override
  void dispose() {
    key.currentState?.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      appBar: AppBarWithStyledLeading(
        title: context.loc.personal_info,
        isSliver: false,
      ),
      body: SafeArea(
        child: Column(
          spacing: AppDimensions.paddingSmall,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            StyledBackgroundContainer(
              child: Form(
                key: key,
                child: Column(
                  spacing: AppDimensions.paddingExtraLarge,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StandardInputField(
                      props: StandardInputFieldProps(
                        labelText: context.loc.name_surname,
                        textEditingController: nameController,
                      ),
                    ),
                    StandardInputField(
                      props: StandardInputFieldProps(
                        labelText: context.loc.email,
                        textEditingController: emailController,
                        validator: ValidationBuilder(
                          localeName: context.loc.localeName,
                          optional: true,
                        ).email().build(),
                      ),
                    ),
                    PhoneInputField(
                      props: PhoneInputFieldProps(
                        textEditingController: phoneController,
                        enabled: false,
                      ),
                    ),
                    StandardInputField(
                      props: StandardInputFieldProps(
                        labelText: context.loc.address,
                        textEditingController: addressController,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.your_gender,
                          style: context.textTheme.appTitle,
                        ),
                        Text('(${context.loc.you_can_change_once_per_month})'),
                      ],
                    ),
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
            ),
            StyledBackgroundContainer(
              child: ElevatedButtonWithState(
                isLoading: false,
                onPressed: () {
                  if (!(key.currentState!.validate())) {
                    return;
                  }
                },
                child: Text(context.loc.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
