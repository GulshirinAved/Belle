// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_client_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterClientController on _RegisterClientControllerBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_RegisterClientControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isErrorComputed;

  @override
  bool get isError => (_$isErrorComputed ??= Computed<bool>(() => super.isError,
          name: '_RegisterClientControllerBase.isError'))
      .value;

  late final _$_registerResponseAtom = Atom(
      name: '_RegisterClientControllerBase._registerResponse',
      context: context);

  @override
  ObservableFuture<ObjectResponse<dynamic>> get _registerResponse {
    _$_registerResponseAtom.reportRead();
    return super._registerResponse;
  }

  @override
  set _registerResponse(ObservableFuture<ObjectResponse<dynamic>> value) {
    _$_registerResponseAtom.reportWrite(value, super._registerResponse, () {
      super._registerResponse = value;
    });
  }

  late final _$genderAtom =
      Atom(name: '_RegisterClientControllerBase.gender', context: context);

  @override
  int get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(int value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$agreeAtom =
      Atom(name: '_RegisterClientControllerBase.agree', context: context);

  @override
  bool get agree {
    _$agreeAtom.reportRead();
    return super.agree;
  }

  @override
  set agree(bool value) {
    _$agreeAtom.reportWrite(value, super.agree, () {
      super.agree = value;
    });
  }

  late final _$registerClientAsyncAction = AsyncAction(
      '_RegisterClientControllerBase.registerClient',
      context: context);

  @override
  Future<void> registerClient(void Function() successCallback) {
    return _$registerClientAsyncAction
        .run(() => super.registerClient(successCallback));
  }

  late final _$_RegisterClientControllerBaseActionController =
      ActionController(name: '_RegisterClientControllerBase', context: context);

  @override
  void toggleGender(int value) {
    final _$actionInfo = _$_RegisterClientControllerBaseActionController
        .startAction(name: '_RegisterClientControllerBase.toggleGender');
    try {
      return super.toggleGender(value);
    } finally {
      _$_RegisterClientControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAgree() {
    final _$actionInfo = _$_RegisterClientControllerBaseActionController
        .startAction(name: '_RegisterClientControllerBase.toggleAgree');
    try {
      return super.toggleAgree();
    } finally {
      _$_RegisterClientControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gender: ${gender},
agree: ${agree},
isLoading: ${isLoading},
isError: ${isError}
    ''';
  }
}
