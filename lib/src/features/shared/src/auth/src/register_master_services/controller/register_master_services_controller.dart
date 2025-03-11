import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'register_master_services_controller.g.dart';

class RegisterMasterServicesController
    extends BaseController<ClientServiceDto> {
  final repository = GetIt.instance<ClientHomeRepository>();

  ClientServicesParams? params;

  void init(int? masterTypeId) {
    _setupParams(masterTypeId);
    _fetchServices();
  }

  void _setupParams(int? masterTypeId) {
    params = ClientServicesParams(
      masterTypeId: masterTypeId,
    );
  }

  Future<void> _fetchServices() async {
    if (params == null) {
      return;
    }
    await loadInitialListData(
      ({size, number}) => repository.fetchServices(
        params: params!,
      ),
    );
  }
}

class RegisterMasterServicesStateController = _RegisterMasterServicesStateControllerBase
    with _$RegisterMasterServicesStateController;

abstract class _RegisterMasterServicesStateControllerBase with Store {
  @observable
  MasterType currentMasterType = MasterType.women;

  @observable
  ClientServiceDto? serviceDto;

  @action
  void setMasterType(MasterType type) {
    if (currentMasterType == type) {
      return;
    }
    currentMasterType = type;
  }

  @action
  void changeSelectedService(ClientServiceDto service) {
    if (serviceDto == service) {
      return;
    }
    serviceDto = service;
  }
}
