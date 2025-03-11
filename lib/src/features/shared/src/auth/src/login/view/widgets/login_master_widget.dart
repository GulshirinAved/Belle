import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../theme/theme.dart';
import '../../../../../../../../widgets/widgets.dart';

class LoginMasterWidget extends StatefulWidget {
  final LoginMasterController controller;
  const LoginMasterWidget({super.key, required this.controller});

  @override
  State<LoginMasterWidget> createState() => _LoginMasterWidgetState();
}

class _LoginMasterWidgetState extends State<LoginMasterWidget>
    with AutomaticKeepAliveClientMixin {
  final key = GlobalKey<FormState>();
  late final LoginMasterController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   key.currentState?.dispose();
  //   super.dispose();
  // }

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
                child: Column(
              children: [
                PhoneInputField(
                  props: PhoneInputFieldProps(
                    textEditingController: controller.phoneController,
                  ),
                ),
                const VSpacer(AppDimensions.paddingMedium),
                PasswordInputField(
                  props: PasswordInputFieldProps(
                    textEditingController: controller.passwordController,
                  ),
                ),
              ],
            )),
            const VSpacer(AppDimensions.paddingMedium),
            StyledBackgroundContainer(
              child: Observer(builder: (context) {
                return ElevatedButtonWithState(
                  isLoading: controller.isLoading,
                  onPressed: () {
                    if (!controller.validateForm(key)) {
                      return;
                    }
                    controller.loginMaster(() {
                      context.goNamed(
                        MasterRoutes.home,
                      );
                    });
                  },
                  child: Text(context.loc.continue_title),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
