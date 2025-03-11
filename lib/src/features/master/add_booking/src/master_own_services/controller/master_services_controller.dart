import 'dart:developer';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'package:belle/src/utils/utils.dart';

import '../../../../../client/client.dart';

part 'master_services_controller.g.dart';

class MasterServicesController extends BaseController<MasterOwnServicesDto> {
  final _repository = GetIt.instance<MasterOwnServicesRepository>();

  Future<void> fetchOwnServices(
      {String? time, required VoidCallback onSuccess}) async {
    await loadInitialListData(
      ({int? size, int? number}) => _repository.fetchOwnServices(
        time: time,
      ),
    );
    if (!stateManager.isSuccess) {
      return;
    }
    onSuccess();
  }
}

class MasterServicesStateController = _MasterServicesStateControllerBase
    with _$MasterServicesStateController;

abstract class _MasterServicesStateControllerBase with Store {
  @observable
  List<MasterOwnServicesDto>? services;

  String? time;

  @observable
  ObservableList<int?> chosenServices = ObservableList();

  @observable
  ObservableList<MasterOwnSubserviceDto> chosenServicesList = ObservableList();

  @observable
  ObservableList<MasterOwnSubserviceDto> subservices = ObservableList();

  @observable
  int? selectedServiceId;

  @observable
  ChosenMasterServicesToSendDto? chosenServicesToSendDto;

  @action
  void initData(List<MasterOwnServicesDto>? value, String? time,
      BuildContext context, List<int?> chosenServices) {
    this.time = time;
    services = value;
    if (services?.isNotEmpty == true) {
      if (services?.indexWhere((el) => el.serviceId == -1) == -1) {
        final allService = MasterOwnServicesDto(
          serviceId: -1,
          name: context.loc.all,
        );
        services?.insert(0, allService);
      }
      selectedServiceId = services?.first.serviceId;
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
    if (services?.isEmpty ?? true) {
      subservices.clear();
      return;
    }

    if (selectedServiceId == -1) {
      final subs = <MasterOwnSubserviceDto>[];
      for (final el in services ?? <MasterOwnServicesDto>[]) {
        subs.addAll(el.subservices ?? []);
      }
      subservices = ObservableList.of(subs);
      return;
    }

    final index = services
        ?.indexWhere((service) => service.serviceId == selectedServiceId);

    if (index == null || index == -1) {
      subservices.clear();
      return;
    }
    subservices = ObservableList.of(services?[index].subservices ?? []);
  }

  @action
  void chooseService(int? id) {
    chosenServices.changeState(id);
    chosenServicesList
        .changeState(subservices.firstWhere((e) => e.subserviceId == id));
    log(chosenServicesList.toString());
  }

  // @action
  ChosenMasterServicesToSendDto handleOnContinue() {
    final data = ChosenMasterServicesToSendDto(
      subServicesIds: chosenServices,
      year: DateTime.now().year,
      month: DateTime.now().month,
      time: time,
      subservices: chosenServicesList,
    );
    return data;
  }
}
