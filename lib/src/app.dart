import 'package:belle/src/features/language/controller/language_controller.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'core/core.dart';
import 'features/client/home/controller/master_type_controller.dart';
import 'theme/theme.dart';

class BelleApp extends StatefulWidget {
  const BelleApp({super.key});

  @override
  State<BelleApp> createState() => _BelleAppState();
}

class _BelleAppState extends State<BelleApp> {
  final rootKey = GlobalKey<NavigatorState>();
  final clientNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'client');
  final masterNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'master');

  final localizationController = GetIt.instance<LanguageController>();
  final themeController = GetIt.instance<ThemeController>();
  final masterTypeController = GetIt.instance<MasterTypeController>();

  AppRouterConfig? _appRouterConfig;

  @override
  void initState() {
    _appRouterConfig = AppRouterConfig(
      rootState: rootKey,
      clientState: clientNavigatorKey,
      masterState: masterNavigatorKey,
    );
    masterTypeController.init();
    super.initState();
  }

  @override
  void dispose() {
    rootKey.currentState?.dispose();
    clientNavigatorKey.currentState?.dispose();
    masterNavigatorKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MaterialApp.router(
        title: 'Belle',
        debugShowCheckedModeBanner: false,
        themeMode: themeController.themeMode,
        theme: themeController.getCurrentThemeData(),
        // darkTheme: AppTheme.darkTheme(),
        locale: localizationController.locale,
        localizationsDelegates: L10n.appDelegates,
        supportedLocales: L10n.supportedLocales,

        routerConfig: _appRouterConfig?.router,
      );
    });
  }
}
