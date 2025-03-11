// ignore_for_file: library_private_types_in_public_api
import 'package:belle/src/features/client/api_models/src/pagination_params.dart';
import 'package:get_it/get_it.dart';
import 'package:belle/src/utils/utils.dart';

import '../../master.dart';

import 'package:mobx/mobx.dart';

part 'master_my_services_controller.g.dart';

class MasterMyServicesController extends BaseController<MasterServiceDto> {
  final _repository = GetIt.instance<MasterMyServicesRepository>();

  Future<void> fetchServices() async {
    loadInitialListData(
      ({int? size, int? number}) => _repository.fetchMasterServices(),
    );
  }

  Future<void> fetchMoreServices() async {
    loadMoreListData(
      ({int? size, int? number}) => _repository.fetchMasterServices(
        params: PaginationParams(size: size, number: number),
      ),
    );
  }
}

class MasterMyServicesEditController extends BaseController<void> {
  final _repository = GetIt.instance<MasterMyServicesRepository>();

  Future<void> saveMainService(int? id) async {
    await postData(
      () => _repository.saveMainService(id: id).then((value) {
        handleSuccess(value.message);
        return value;
      }),
    );
  }
}

class MasterMyServicesStateController = _MasterMyServicesStateControllerBase
    with _$MasterMyServicesStateController;

abstract class _MasterMyServicesStateControllerBase
    with Store, HandlingErrorMixin {
  @observable
  int? isMainId = -1;

  int initialIndex = -1;

  void init(
    List<MasterServiceDto> items,
  ) {
    final index = items.indexWhere((element) => element.isMain == true);
    if (index == -1) {
      return;
    }
    initialIndex = items[index].subserviceId ?? -1;
    isMainId = initialIndex;
  }

  @action
  void setMainId(int? value) {
    isMainId = value;
  }
}
