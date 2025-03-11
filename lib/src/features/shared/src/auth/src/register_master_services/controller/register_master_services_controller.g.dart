// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_master_services_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterMasterServicesStateController
    on _RegisterMasterServicesStateControllerBase, Store {
  late final _$currentMasterTypeAtom = Atom(
      name: '_RegisterMasterServicesStateControllerBase.currentMasterType',
      context: context);

  @override
  MasterType get currentMasterType {
    _$currentMasterTypeAtom.reportRead();
    return super.currentMasterType;
  }

  @override
  set currentMasterType(MasterType value) {
    _$currentMasterTypeAtom.reportWrite(value, super.currentMasterType, () {
      super.currentMasterType = value;
    });
  }

  late final _$serviceDtoAtom = Atom(
      name: '_RegisterMasterServicesStateControllerBase.serviceDto',
      context: context);

  @override
  ClientServiceDto? get serviceDto {
    _$serviceDtoAtom.reportRead();
    return super.serviceDto;
  }

  @override
  set serviceDto(ClientServiceDto? value) {
    _$serviceDtoAtom.reportWrite(value, super.serviceDto, () {
      super.serviceDto = value;
    });
  }

  late final _$_RegisterMasterServicesStateControllerBaseActionController =
      ActionController(
          name: '_RegisterMasterServicesStateControllerBase', context: context);

  @override
  void setMasterType(MasterType type) {
    final _$actionInfo =
        _$_RegisterMasterServicesStateControllerBaseActionController
            .startAction(
                name:
                    '_RegisterMasterServicesStateControllerBase.setMasterType');
    try {
      return super.setMasterType(type);
    } finally {
      _$_RegisterMasterServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedService(ClientServiceDto service) {
    final _$actionInfo =
        _$_RegisterMasterServicesStateControllerBaseActionController.startAction(
            name:
                '_RegisterMasterServicesStateControllerBase.changeSelectedService');
    try {
      return super.changeSelectedService(service);
    } finally {
      _$_RegisterMasterServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentMasterType: ${currentMasterType},
serviceDto: ${serviceDto}
    ''';
  }
}
