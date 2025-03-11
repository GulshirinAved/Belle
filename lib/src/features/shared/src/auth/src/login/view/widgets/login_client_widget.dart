import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../theme/theme.dart';
import '../../../../../../../../widgets/widgets.dart';
import '../../../../../../shared.dart';

class LoginClientWidget extends StatefulWidget {
  final LoginClientController controller;
  const LoginClientWidget({super.key, required this.controller});

  @override
  State<LoginClientWidget> createState() => _LoginClientWidgetState();
}

class _LoginClientWidgetState extends State<LoginClientWidget>
    with AutomaticKeepAliveClientMixin {
  final key = GlobalKey<FormState>();
  late final LoginClientController controller;

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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StyledBackgroundContainer(
              child: PhoneInputField(
                props: PhoneInputFieldProps(
                  textEditingController: controller.phoneController,
                ),
              ),
            ),
            const VSpacer(AppDimensions.paddingMedium),
            StyledBackgroundContainer(
              child: ElevatedButtonWithState(
                isLoading: controller.isLoading,
                onPressed: () {
                  if (!controller.validateForm(key)) {
                    return;
                  }
                  // context.pushNamed(
                  //   SharedRoutes.otp,
                  //   extra: OtpRouteModel(controller.phoneController.text),
                  // );
                  controller.loginClient(() {
                    context.pushNamed(
                      SharedRoutes.loginClientOtp,
                      extra: controller.generateLoginModel(),
                    );
                  });
                },
                child: Text(context.loc.continue_title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
