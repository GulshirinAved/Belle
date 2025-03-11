import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../../theme/theme.dart';
import '../../../../../../../widgets/widgets.dart';
import '../../../../../../client/client.dart';
import '../../../../../shared.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /// initialize controllers here for
  /// saving states
  /// control loading status
  /// disabling scroll and changing tab
  final registerClientController = GetIt.instance<RegisterClientController>();
  final registerMasterController = GetIt.instance<RegisterMasterController>();
  final servicesController = GetIt.instance<ServicesController>();

  final pageController = PageController();

  UserType userType = UserType.client;

  @override
  void initState() {
    registerMasterController.setContext(context);
    registerClientController.setContext(context);
    super.initState();
  }

  @override
  void dispose() {
    registerMasterController.disposeContext();
    registerClientController.disposeContext();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.register),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingMedium,
            ),
            child: AnimatedToggleWidget<UserType>(
              initialValue: UserType.client,
              onChanged: (value) {
                if (registerClientController.isLoading ||
                    registerMasterController.isLoading) {
                  return;
                }
                if (value == UserType.client) {
                  pageController.jumpToPage(0);
                } else {
                  pageController.jumpToPage(1);
                }
                userType = value;
                setState(() {});
              },
              props: AnimatedToggleWidgetProps<UserType>(
                selectedValue: userType,
              ),
              items: [
                AnimatedToggleWidgetItem(
                  value: UserType.client,
                  title: context.loc.client,
                ),
                AnimatedToggleWidgetItem(
                  value: UserType.master,
                  title: context.loc.master,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          return PageView(
            controller: pageController,
            physics: registerClientController.isLoading ||
                registerMasterController.isLoading
                ? const NeverScrollableScrollPhysics()
                : null,
            onPageChanged: (value) {
              if (userType == UserType.client) {
                userType = UserType.master;
              } else {
                userType = UserType.client;
              }
              setState(() {});
            },
            children: [
              RegisterClientWidget(
                controller: registerClientController,
              ),
              RegisterMasterWidget(
                controller: registerMasterController,
                servicesController: servicesController,
              ),
            ],
          );
        }),
      ),
    );
  }
}
