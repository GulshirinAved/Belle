// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_status_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStatusController on _AuthStatusControllerBase, Store {
  late final _$authLoginStatusAtom =
      Atom(name: '_AuthStatusControllerBase.authLoginStatus', context: context);

  @override
  AuthLoginStatus get authLoginStatus {
    _$authLoginStatusAtom.reportRead();
    return super.authLoginStatus;
  }

  @override
  set authLoginStatus(AuthLoginStatus value) {
    _$authLoginStatusAtom.reportWrite(value, super.authLoginStatus, () {
      super.authLoginStatus = value;
    });
  }

  late final _$_AuthStatusControllerBaseActionController =
      ActionController(name: '_AuthStatusControllerBase', context: context);

  @override
  void getAuthStatus(ObservableFuture<dynamic> authResponse) {
    final _$actionInfo = _$_AuthStatusControllerBaseActionController
        .startAction(name: '_AuthStatusControllerBase.getAuthStatus');
    try {
      return super.getAuthStatus(authResponse);
    } finally {
      _$_AuthStatusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
authLoginStatus: ${authLoginStatus}
    ''';
  }
}
