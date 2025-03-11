// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_booking_clients_state_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterBookingClientsStateController
    on _MasterBookingClientsStateControllerBase, Store {
  late final _$dataAtom = Atom(
      name: '_MasterBookingClientsStateControllerBase.data', context: context);

  @override
  ChosenMasterServicesToSendDto? get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ChosenMasterServicesToSendDto? value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$selectedClientAtom = Atom(
      name: '_MasterBookingClientsStateControllerBase.selectedClient',
      context: context);

  @override
  MasterClientDto? get selectedClient {
    _$selectedClientAtom.reportRead();
    return super.selectedClient;
  }

  @override
  set selectedClient(MasterClientDto? value) {
    _$selectedClientAtom.reportWrite(value, super.selectedClient, () {
      super.selectedClient = value;
    });
  }

  late final _$_MasterBookingClientsStateControllerBaseActionController =
      ActionController(
          name: '_MasterBookingClientsStateControllerBase', context: context);

  @override
  void initData(ChosenMasterServicesToSendDto? data) {
    final _$actionInfo =
        _$_MasterBookingClientsStateControllerBaseActionController.startAction(
            name: '_MasterBookingClientsStateControllerBase.initData');
    try {
      return super.initData(data);
    } finally {
      _$_MasterBookingClientsStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedClient(MasterClientDto? value) {
    final _$actionInfo =
        _$_MasterBookingClientsStateControllerBaseActionController.startAction(
            name:
                '_MasterBookingClientsStateControllerBase.changeSelectedClient');
    try {
      return super.changeSelectedClient(value);
    } finally {
      _$_MasterBookingClientsStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
data: ${data},
selectedClient: ${selectedClient}
    ''';
  }
}
