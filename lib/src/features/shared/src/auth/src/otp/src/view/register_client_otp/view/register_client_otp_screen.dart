import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../shared.dart';
import '../../../../../../../../../../theme/theme.dart';
import '../../../../../../../../../../widgets/widgets.dart';

class RegisterClientOtpScreen extends StatefulWidget {
  // final int codeId;
  final RegisterClientDto? data;

  const RegisterClientOtpScreen({
    super.key,
    required this.data,
  });

  @override
  State<RegisterClientOtpScreen> createState() =>
      _RegisterClientOtpScreenState();
}

class _RegisterClientOtpScreenState extends State<RegisterClientOtpScreen> {
  final controller = GetIt.instance<RegisterClientOtpController>();
  late final String phone;
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String code = '';

  @override
  void initState() {
    controller.setContext(context);
    controller.setupData(widget.data);
    phone = widget.data?.phone ?? '65656565';
    super.initState();
  }

  @override
  void dispose() {
    controller.disposeContext();
    otpController.dispose();
    formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const AppBarWithStyledLeading(title: ''),
            SliverFillRemaining(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium),
                    child: Text(
                      context.loc.we_sent_otp_code,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const VSpacer(AppDimensions.paddingMedium),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium),
                    child: Text(
                      context.loc.please_check_your_phone(
                        phone.substring(0, 2),
                        phone.substring(6),
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const VSpacer(AppDimensions.paddingMedium),
                  StyledBackgroundContainer(
                    child: Form(
                      key: formKey,
                      child: OtpInputWidget(
                        onCompleted: (value) {
                          code = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.loc.required;
                          }
                          return null;
                        },
                        controller: otpController,
                      ),
                    ),
                  ),
                  const VSpacer(AppDimensions.paddingMedium),
                  StyledBackgroundContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Observer(builder: (context) {
                          return ElevatedButtonWithState(
                            isLoading: controller.isLoading,
                            onPressed: () {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              controller.handleOnContinue(code, () {
                                context.goNamed(ClientRoutes.profile);
                              });
                            },
                            child: Text(context.loc.continue_title),
                          );
                        }),
                        const VSpacer(AppDimensions.paddingMedium),
                        ResendCodeButton(
                          onPressed: () {
                            formKey.currentState?.reset();

                            otpController.clear();

                            controller.resendCode();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
