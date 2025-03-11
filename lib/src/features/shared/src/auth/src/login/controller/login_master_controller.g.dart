// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_master_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginMasterController on _LoginMasterControllerBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_LoginMasterControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isErrorComputed;

  @override
  bool get isError => (_$isErrorComputed ??= Computed<bool>(() => super.isError,
          name: '_LoginMasterControllerBase.isError'))
      .value;

  late final _$_loginResponseAtom =
      Atom(name: '_LoginMasterControllerBase._loginResponse', context: context);

  @override
  ObservableFuture<ObjectResponse<TokenDto>> get _loginResponse {
    _$_loginResponseAtom.reportRead();
    return super._loginResponse;
  }

  @override
  set _loginResponse(ObservableFuture<ObjectResponse<TokenDto>> value) {
    _$_loginResponseAtom.reportWrite(value, super._loginResponse, () {
      super._loginResponse = value;
    });
  }

  late final _$_firebaseResponseAtom = Atom(
      name: '_LoginMasterControllerBase._firebaseResponse', context: context);

  @override
  ObservableFuture<void> get _firebaseResponse {
    _$_firebaseResponseAtom.reportRead();
    return super._firebaseResponse;
  }

  @override
  set _firebaseResponse(ObservableFuture<void> value) {
    _$_firebaseResponseAtom.reportWrite(value, super._firebaseResponse, () {
      super._firebaseResponse = value;
    });
  }

  late final _$loginMasterAsyncAction =
      AsyncAction('_LoginMasterControllerBase.loginMaster', context: context);

  @override
  Future<void> loginMaster(void Function() successCallback) {
    return _$loginMasterAsyncAction
        .run(() => super.loginMaster(successCallback));
  }

  late final _$_firebaseSubscriptionAsyncAction = AsyncAction(
      '_LoginMasterControllerBase._firebaseSubscription',
      context: context);

  @override
  Future<void> _firebaseSubscription(String accessToken) {
    return _$_firebaseSubscriptionAsyncAction
        .run(() => super._firebaseSubscription(accessToken));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError}
    ''';
  }
}
