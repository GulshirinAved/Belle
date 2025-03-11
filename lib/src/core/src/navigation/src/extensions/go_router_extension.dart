import 'dart:developer';

import 'package:go_router/go_router.dart';

extension GoRouterExt on GoRouter {
  String get _currentRoute =>
      routerDelegate.currentConfiguration.matches.last.matchedLocation;

  /// Pop until the route with the given [path] is reached.
  /// Example
  /// ``` dart
  ///  GoRouter.of(context).popUntil(SettingsScreen.route);
  /// ```

  void popUntil<T>(String path, [T? result]) {
    var currentRoute = _currentRoute;
    while (currentRoute != path && canPop()) {
      log('currentRoute: $currentRoute');
      pop(result);
      currentRoute = _currentRoute;
    }
  }
}
