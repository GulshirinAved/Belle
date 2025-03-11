import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:belle/src/utils/utils.dart';

part 'master_info_controller.g.dart';

class ClientMasterReviewsController
    extends BaseController<ClientMasterReviewDto> {
  final _repository = GetIt.instance<ClientMasterInfoRepository>();

  ClientMasterReviewsParams? params;

  void setupParams(int? masterId) {
    params = ClientMasterReviewsParams(masterId: masterId);
  }

  Future<void> fetchReviews() async {
    if (params == null) {
      return;
    }
    await loadInitialListData(({int? number, int? size}) =>
        _repository.fetchMasterReviews(params: params!));
  }

  Future<void> fetchMoreReviews() async {
    if (params == null) {
      return;
    }
    await loadMoreListData(
      ({int? number, int? size}) => _repository.fetchMasterReviews(
        params: params!.copyWith(
          size: size,
          number: number,
        ),
      ),
    );
  }
}

class ClientMasterInfoController extends BaseController<ClientMasterInfoDto> {
  final _repository = GetIt.instance<ClientMasterInfoRepository>();

  Future<void> fetchMasterInfo(int? id, VoidCallback onSuccess) async {
    await fetchData(() => _repository.fetchMasterInfo(id: id));
    onSuccess();
  }
}

class ClientMasterInfoStateController = _ClientMasterInfoStateControllerBase
    with _$ClientMasterInfoStateController;

abstract class _ClientMasterInfoStateControllerBase with Store {
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
  void initData(ClientMasterInfoDto? value, BuildContext context) {
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
