// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_master_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterMasterController on _RegisterMasterControllerBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_RegisterMasterControllerBase.isLoading'))
          .value;
  Computed<bool>? _$isErrorComputed;

  @override
  bool get isError => (_$isErrorComputed ??= Computed<bool>(() => super.isError,
          name: '_RegisterMasterControllerBase.isError'))
      .value;

  late final _$_registerResponseAtom = Atom(
      name: '_RegisterMasterControllerBase._registerResponse',
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

  late final _$selectedWorkingLocationsAtom = Atom(
      name: '_RegisterMasterControllerBase.selectedWorkingLocations',
      context: context);

  @override
  ObservableList<int> get selectedWorkingLocations {
    _$selectedWorkingLocationsAtom.reportRead();
    return super.selectedWorkingLocations;
  }

  @override
  set selectedWorkingLocations(ObservableList<int> value) {
    _$selectedWorkingLocationsAtom
        .reportWrite(value, super.selectedWorkingLocations, () {
      super.selectedWorkingLocations = value;
    });
  }

  late final _$selectedServiceAtom = Atom(
      name: '_RegisterMasterControllerBase.selectedService', context: context);

  @override
  ClientServiceDto? get selectedService {
    _$selectedServiceAtom.reportRead();
    return super.selectedService;
  }

  @override
  set selectedService(ClientServiceDto? value) {
    _$selectedServiceAtom.reportWrite(value, super.selectedService, () {
      super.selectedService = value;
    });
  }

  late final _$genderAtom =
      Atom(name: '_RegisterMasterControllerBase.gender', context: context);

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
      Atom(name: '_RegisterMasterControllerBase.agree', context: context);

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

  late final _$registerMasterAsyncAction = AsyncAction(
      '_RegisterMasterControllerBase.registerMaster',
      context: context);

  @override
  Future<void> registerMaster(VoidCallback successCallback) {
    return _$registerMasterAsyncAction
        .run(() => super.registerMaster(successCallback));
  }

  late final _$_RegisterMasterControllerBaseActionController =
      ActionController(name: '_RegisterMasterControllerBase', context: context);

  @override
  void changeSelectedService(ClientServiceDto service) {
    final _$actionInfo =
        _$_RegisterMasterControllerBaseActionController.startAction(
            name: '_RegisterMasterControllerBase.changeSelectedService');
    try {
      return super.changeSelectedService(service);
    } finally {
      _$_RegisterMasterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleGender(int value) {
    final _$actionInfo = _$_RegisterMasterControllerBaseActionController
        .startAction(name: '_RegisterMasterControllerBase.toggleGender');
    try {
      return super.toggleGender(value);
    } finally {
      _$_RegisterMasterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSelectedWorkingLocation(int id) {
    final _$actionInfo =
        _$_RegisterMasterControllerBaseActionController.startAction(
            name:
                '_RegisterMasterControllerBase.toggleSelectedWorkingLocation');
    try {
      return super.toggleSelectedWorkingLocation(id);
    } finally {
      _$_RegisterMasterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAgree() {
    final _$actionInfo = _$_RegisterMasterControllerBaseActionController
        .startAction(name: '_RegisterMasterControllerBase.toggleAgree');
    try {
      return super.toggleAgree();
    } finally {
      _$_RegisterMasterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedWorkingLocations: ${selectedWorkingLocations},
selectedService: ${selectedService},
gender: ${gender},
agree: ${agree},
isLoading: ${isLoading},
isError: ${isError}
    ''';
  }
}
