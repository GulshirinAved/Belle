// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_booking_now_services_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClientBookingNowServicesStateController
    on _ClientBookingNowServicesStateControllerBase, Store {
  late final _$dataAtom = Atom(
      name: '_ClientBookingNowServicesStateControllerBase.data',
      context: context);

  @override
  ClientMasterInfoDto? get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ClientMasterInfoDto? value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$chosenServicesAtom = Atom(
      name: '_ClientBookingNowServicesStateControllerBase.chosenServices',
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

  late final _$subservicesAtom = Atom(
      name: '_ClientBookingNowServicesStateControllerBase.subservices',
      context: context);

  @override
  ObservableList<Subservice> get subservices {
    _$subservicesAtom.reportRead();
    return super.subservices;
  }

  @override
  set subservices(ObservableList<Subservice> value) {
    _$subservicesAtom.reportWrite(value, super.subservices, () {
      super.subservices = value;
    });
  }

  late final _$selectedServiceIdAtom = Atom(
      name: '_ClientBookingNowServicesStateControllerBase.selectedServiceId',
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
      name:
          '_ClientBookingNowServicesStateControllerBase.chosenServicesToSendDto',
      context: context);

  @override
  ChosenServicesToSendDto? get chosenServicesToSendDto {
    _$chosenServicesToSendDtoAtom.reportRead();
    return super.chosenServicesToSendDto;
  }

  @override
  set chosenServicesToSendDto(ChosenServicesToSendDto? value) {
    _$chosenServicesToSendDtoAtom
        .reportWrite(value, super.chosenServicesToSendDto, () {
      super.chosenServicesToSendDto = value;
    });
  }

  late final _$_ClientBookingNowServicesStateControllerBaseActionController =
      ActionController(
          name: '_ClientBookingNowServicesStateControllerBase',
          context: context);

  @override
  void initData(ClientMasterInfoDto? value, BuildContext context,
      List<int?> chosenServices) {
    final _$actionInfo =
        _$_ClientBookingNowServicesStateControllerBaseActionController
            .startAction(
                name: '_ClientBookingNowServicesStateControllerBase.initData');
    try {
      return super.initData(value, context, chosenServices);
    } finally {
      _$_ClientBookingNowServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentSelectedServiceId(int? id) {
    final _$actionInfo =
        _$_ClientBookingNowServicesStateControllerBaseActionController.startAction(
            name:
                '_ClientBookingNowServicesStateControllerBase.changeCurrentSelectedServiceId');
    try {
      return super.changeCurrentSelectedServiceId(id);
    } finally {
      _$_ClientBookingNowServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void calculateSubservicesById() {
    final _$actionInfo =
        _$_ClientBookingNowServicesStateControllerBaseActionController.startAction(
            name:
                '_ClientBookingNowServicesStateControllerBase.calculateSubservicesById');
    try {
      return super.calculateSubservicesById();
    } finally {
      _$_ClientBookingNowServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void chooseService(int? id) {
    final _$actionInfo =
        _$_ClientBookingNowServicesStateControllerBaseActionController
            .startAction(
                name:
                    '_ClientBookingNowServicesStateControllerBase.chooseService');
    try {
      return super.chooseService(id);
    } finally {
      _$_ClientBookingNowServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void handleOnContinue() {
    final _$actionInfo =
        _$_ClientBookingNowServicesStateControllerBaseActionController.startAction(
            name:
                '_ClientBookingNowServicesStateControllerBase.handleOnContinue');
    try {
      return super.handleOnContinue();
    } finally {
      _$_ClientBookingNowServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
data: ${data},
chosenServices: ${chosenServices},
subservices: ${subservices},
selectedServiceId: ${selectedServiceId},
chosenServicesToSendDto: ${chosenServicesToSendDto}
    ''';
  }
}
