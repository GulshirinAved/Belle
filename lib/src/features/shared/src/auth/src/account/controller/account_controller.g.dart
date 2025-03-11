// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountController on _AccountControllerBase, Store {
  Computed<AccountDto?>? _$accountInfoComputed;

  @override
  AccountDto? get accountInfo =>
      (_$accountInfoComputed ??= Computed<AccountDto?>(() => super.accountInfo,
              name: '_AccountControllerBase.accountInfo'))
          .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_AccountControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isErrorComputed;

  @override
  bool get isError => (_$isErrorComputed ??= Computed<bool>(() => super.isError,
          name: '_AccountControllerBase.isError'))
      .value;
  Computed<bool>? _$isSuccessComputed;

  @override
  bool get isSuccess =>
      (_$isSuccessComputed ??= Computed<bool>(() => super.isSuccess,
              name: '_AccountControllerBase.isSuccess'))
          .value;

  late final _$_observableAccountAtom =
      Atom(name: '_AccountControllerBase._observableAccount', context: context);

  ObservableFuture<ObjectResponse<AccountDto?>> get observableAccount {
    _$_observableAccountAtom.reportRead();
    return super._observableAccount;
  }

  @override
  ObservableFuture<ObjectResponse<AccountDto?>> get _observableAccount =>
      observableAccount;

  @override
  set _observableAccount(ObservableFuture<ObjectResponse<AccountDto?>> value) {
    _$_observableAccountAtom.reportWrite(value, super._observableAccount, () {
      super._observableAccount = value;
    });
  }

  late final _$_firebaseSubscriptionAtom = Atom(
      name: '_AccountControllerBase._firebaseSubscription', context: context);

  ObservableFuture<void> get firebaseSubscription {
    _$_firebaseSubscriptionAtom.reportRead();
    return super._firebaseSubscription;
  }

  @override
  ObservableFuture<void> get _firebaseSubscription => firebaseSubscription;

  @override
  set _firebaseSubscription(ObservableFuture<void> value) {
    _$_firebaseSubscriptionAtom.reportWrite(value, super._firebaseSubscription,
        () {
      super._firebaseSubscription = value;
    });
  }

  late final _$getAccountAsyncAction =
      AsyncAction('_AccountControllerBase.getAccount', context: context);

  @override
  Future<void> getAccount() {
    return _$getAccountAsyncAction.run(() => super.getAccount());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AccountControllerBase.logout', context: context);

  @override
  Future<void> logout(VoidCallback navigateToLogin) {
    return _$logoutAsyncAction.run(() => super.logout(navigateToLogin));
  }

  late final _$_AccountControllerBaseActionController =
      ActionController(name: '_AccountControllerBase', context: context);

  @override
  void setAccount(ObjectResponse<AccountDto> account) {
    final _$actionInfo = _$_AccountControllerBaseActionController.startAction(
        name: '_AccountControllerBase.setAccount');
    try {
      return super.setAccount(account);
    } finally {
      _$_AccountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteAccount(
      VoidCallback successCallback, void Function(dynamic) errorCallback) {
    final _$actionInfo = _$_AccountControllerBaseActionController.startAction(
        name: '_AccountControllerBase.deleteAccount');
    try {
      return super.deleteAccount(successCallback, errorCallback);
    } finally {
      _$_AccountControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
accountInfo: ${accountInfo},
isLoading: ${isLoading},
isError: ${isError},
isSuccess: ${isSuccess}
    ''';
  }
}
