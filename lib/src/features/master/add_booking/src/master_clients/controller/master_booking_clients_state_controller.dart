// ignore_for_file: library_private_types_in_public_api
import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../utils/utils.dart';
import '../../../../master.dart';

part 'master_booking_clients_state_controller.g.dart';

class MasterBookingClientsStateController = _MasterBookingClientsStateControllerBase
    with _$MasterBookingClientsStateController;

abstract class _MasterBookingClientsStateControllerBase
    with Store, HandlingErrorMixin {
  @observable
  ChosenMasterServicesToSendDto? data;

  @observable
  MasterClientDto? selectedClient;

  @action
  void initData(ChosenMasterServicesToSendDto? data) {
    this.data = data;
  }

  @action
  void changeSelectedClient(MasterClientDto? value) {
    selectedClient = value;
  }

  MasterCreateBookingDto handleOnContinue(BuildContext context) {
    data = data?.copyWith(
      clientName: selectedClient?.contactName,
      clientPhone: selectedClient?.contactPhone,
    );
    if (data == null) {
      throw Exception('');
    }
    return MasterCreateBookingDto(
      subServicesIds: data!.subServicesIds,
      clientName: data!.clientName,
      clientPhone: data!.clientPhone,
      subservices: data!.subservices,
      time: data!.time,
      date: DateFormat('yyyy-MM-dd', context.loc.localeName)
          .format(DateTime.now()),
    );
  }
}
