// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_client_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginClientController on _LoginClientControllerBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_LoginClientControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isErrorComputed;

  @override
  bool get isError => (_$isErrorComputed ??= Computed<bool>(() => super.isError,
          name: '_LoginClientControllerBase.isError'))
      .value;

  late final _$_loginResponseAtom =
      Atom(name: '_LoginClientControllerBase._loginResponse', context: context);

  @override
  ObservableFuture<ObjectResponse<dynamic>> get _loginResponse {
    _$_loginResponseAtom.reportRead();
    return super._loginResponse;
  }

  @override
  set _loginResponse(ObservableFuture<ObjectResponse<dynamic>> value) {
    _$_loginResponseAtom.reportWrite(value, super._loginResponse, () {
      super._loginResponse = value;
    });
  }

  late final _$loginClientAsyncAction =
      AsyncAction('_LoginClientControllerBase.loginClient', context: context);

  @override
  Future<void> loginClient(void Function() successCallback) {
    return _$loginClientAsyncAction
        .run(() => super.loginClient(successCallback));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError}
    ''';
  }
}
