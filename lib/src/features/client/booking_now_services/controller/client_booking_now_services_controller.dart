import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../client.dart';
import 'package:belle/src/utils/utils.dart';

part 'client_booking_now_services_controller.g.dart';

class ClientBookingNowServicesController
    extends BaseController<ClientMasterInfoDto> {
  final _repository = GetIt.instance<ClientMasterInfoRepository>();

  Future<void> fetchMasterInfo(int? id, VoidCallback onSuccess) async {
    await fetchData(() => _repository.fetchMasterInfo(id: id));
    onSuccess();
  }
}

class ClientBookingNowServicesStateController = _ClientBookingNowServicesStateControllerBase
    with _$ClientBookingNowServicesStateController;

abstract class _ClientBookingNowServicesStateControllerBase with Store {
  @observable
  ClientMasterInfoDto? data;

  @observable
  ObservableList<int?> chosenServices = ObservableList();

  @observable
  ObservableList<Subservice> subservices = ObservableList();

  @observable
  int? selectedServiceId;

  @observable
  ChosenServicesToSendDto? chosenServicesToSendDto;

  @action
  void initData(ClientMasterInfoDto? value, BuildContext context,
      List<int?> chosenServices) {
    data = value;
    if (data?.services?.isNotEmpty == true) {
      if (data?.services?.indexWhere((el) => el.serviceId == -1) == -1) {
        final allService = ClientMasterServiceDto(
          serviceId: -1,
          name: context.loc.all,
        );
        data?.services?.insert(0, allService);
      }
      selectedServiceId = data?.services?.first.serviceId;
      calculateSubservicesById();
      this.chosenServices.clear();
      this.chosenServices.addAll(chosenServices);
    }
  }

  @action
  void changeCurrentSelectedServiceId(int? id) {
    if (selectedServiceId == id) {
      return;
    }
    selectedServiceId = id;
    calculateSubservicesById();
  }

  @action
  void calculateSubservicesById() {
    if (data?.services?.isEmpty ?? true) {
      subservices.clear();
      return;
    }

    if (selectedServiceId == -1) {
      final subs = <Subservice>[];
      for (final el in data?.services ?? <ClientMasterServiceDto>[]) {
        subs.addAll(el.subservices ?? []);
      }
      subservices = ObservableList.of(subs);
      return;
    }

    final index = data?.services
        ?.indexWhere((service) => service.serviceId == selectedServiceId);

    if (index == null || index == -1) {
      subservices.clear();
      return;
    }
    subservices = ObservableList.of(data?.services?[index].subservices ?? []);
  }

  @action
  void chooseService(int? id) {
    chosenServices.changeState(id);
  }

  @action
  void handleOnContinue() {
    chosenServicesToSendDto = ChosenServicesToSendDto(
      masterId: data?.id,
      subServicesIds: chosenServices,
      year: DateTime.now().year,
      month: DateTime.now().month,
    );
  }
}
