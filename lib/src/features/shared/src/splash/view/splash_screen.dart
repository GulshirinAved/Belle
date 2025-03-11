import 'package:belle/src/core/core.dart';
import 'package:belle/src/widgets/src/state_control_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../shared.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = GetIt.instance<SplashController>();
  final authStatusController = GetIt.instance<AuthStatusController>();
  final accountController = GetIt.instance<AccountController>();
  final referencesController = GetIt.instance<ReferencesController>();
  final roleController = GetIt.instance<RoleController>();

  @override
  void initState() {
    super.initState();
    splashController.initializeApp(navigateToMaster, navigateToClient);
    _initAccountAndRole();
  }

  Future<void> _initAccountAndRole() async {
    accountController.setContext(context);
    roleController.init();
    await accountController.initController();
  }

  void navigateToMaster() {
    context.goNamed(MasterRoutes.home);
  }

  void navigateToClient() {
    context.goNamed(ClientRoutes.home);
  }

  @override
  void dispose() {
    splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return StateControlWidget(
          props: StateControlWidgetProps(
            isLoading:
                authStatusController.authLoginStatus != AuthLoginStatus.error ||
                    referencesController.stateManager.isLoading,
            isError:
                authStatusController.authLoginStatus == AuthLoginStatus.error ||
                    referencesController.stateManager.isError,
            onError: () {
              if (referencesController.stateManager.isError) {
                referencesController.fetchReferences();
              } else if (authStatusController.authLoginStatus ==
                  AuthLoginStatus.error) {
                accountController.getAccount();
              }
            },
          ),
        );
      }),
    );
  }
}
