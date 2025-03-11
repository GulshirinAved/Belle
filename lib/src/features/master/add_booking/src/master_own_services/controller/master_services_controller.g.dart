// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_services_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterServicesStateController
    on _MasterServicesStateControllerBase, Store {
  late final _$servicesAtom = Atom(
      name: '_MasterServicesStateControllerBase.services', context: context);

  @override
  List<MasterOwnServicesDto>? get services {
    _$servicesAtom.reportRead();
    return super.services;
  }

  @override
  set services(List<MasterOwnServicesDto>? value) {
    _$servicesAtom.reportWrite(value, super.services, () {
      super.services = value;
    });
  }

  late final _$chosenServicesAtom = Atom(
      name: '_MasterServicesStateControllerBase.chosenServices',
      context: context);

  @override
  ObservableList<int?> get chosenServices {
    _$chosenServicesAtom.reportRead();
    return super.chosenServices;
  }

  @override
  set chosenServices(ObservableList<int?> value) {
    _$chosenServicesAtom.reportWrite(value, super.chosenServices, () {
      super.chosenServices = value;
    });
  }

  late final _$chosenServicesListAtom = Atom(
      name: '_MasterServicesStateControllerBase.chosenServicesList',
      context: context);

  @override
  ObservableList<MasterOwnSubserviceDto> get chosenServicesList {
    _$chosenServicesListAtom.reportRead();
    return super.chosenServicesList;
  }

  @override
  set chosenServicesList(ObservableList<MasterOwnSubserviceDto> value) {
    _$chosenServicesListAtom.reportWrite(value, super.chosenServicesList, () {
      super.chosenServicesList = value;
    });
  }

  late final _$subservicesAtom = Atom(
      name: '_MasterServicesStateControllerBase.subservices', context: context);

  @override
  ObservableList<MasterOwnSubserviceDto> get subservices {
    _$subservicesAtom.reportRead();
    return super.subservices;
  }

  @override
  set subservices(ObservableList<MasterOwnSubserviceDto> value) {
    _$subservicesAtom.reportWrite(value, super.subservices, () {
      super.subservices = value;
    });
  }

  late final _$selectedServiceIdAtom = Atom(
      name: '_MasterServicesStateControllerBase.selectedServiceId',
      context: context);

  @override
  int? get selectedServiceId {
    _$selectedServiceIdAtom.reportRead();
    return super.selectedServiceId;
  }

  @override
  set selectedServiceId(int? value) {
    _$selectedServiceIdAtom.reportWrite(value, super.selectedServiceId, () {
      super.selectedServiceId = value;
    });
  }

  late final _$chosenServicesToSendDtoAtom = Atom(
      name: '_MasterServicesStateControllerBase.chosenServicesToSendDto',
      context: context);

  @override
  ChosenMasterServicesToSendDto? get chosenServicesToSendDto {
    _$chosenServicesToSendDtoAtom.reportRead();
    return super.chosenServicesToSendDto;
  }

  @override
  set chosenServicesToSendDto(ChosenMasterServicesToSendDto? value) {
    _$chosenServicesToSendDtoAtom
        .reportWrite(value, super.chosenServicesToSendDto, () {
      super.chosenServicesToSendDto = value;
    });
  }

  late final _$_MasterServicesStateControllerBaseActionController =
      ActionController(
          name: '_MasterServicesStateControllerBase', context: context);

  @override
  void initData(List<MasterOwnServicesDto>? value, String? time,
      BuildContext context, List<int?> chosenServices) {
    final _$actionInfo = _$_MasterServicesStateControllerBaseActionController
        .startAction(name: '_MasterServicesStateControllerBase.initData');
    try {
      return super.initData(value, time, context, chosenServices);
    } finally {
      _$_MasterServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentSelectedServiceId(int? id) {
    final _$actionInfo =
        _$_MasterServicesStateControllerBaseActionController.startAction(
            name:
                '_MasterServicesStateControllerBase.changeCurrentSelectedServiceId');
    try {
      return super.changeCurrentSelectedServiceId(id);
    } finally {
      _$_MasterServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void calculateSubservicesById() {
    final _$actionInfo =
        _$_MasterServicesStateControllerBaseActionController.startAction(
            name:
                '_MasterServicesStateControllerBase.calculateSubservicesById');
    try {
      return super.calculateSubservicesById();
    } finally {
      _$_MasterServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void chooseService(int? id) {
    final _$actionInfo = _$_MasterServicesStateControllerBaseActionController
        .startAction(name: '_MasterServicesStateControllerBase.chooseService');
    try {
      return super.chooseService(id);
    } finally {
      _$_MasterServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
services: ${services},
chosenServices: ${chosenServices},
chosenServicesList: ${chosenServicesList},
subservices: ${subservices},
selectedServiceId: ${selectedServiceId},
chosenServicesToSendDto: ${chosenServicesToSendDto}
    ''';
  }
}
