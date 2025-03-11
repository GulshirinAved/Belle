import 'package:belle/src/features/master/master.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

class MasterChooseServiceController extends BaseController<ServiceDetailedDto> {
  final _repository = GetIt.instance<MasterServicesRepository>();
  MasterSubservicesParams? params;

  void init(int? serviceId, [int? genderId]) {
    params = MasterSubservicesParams(
      serviceId: serviceId,
      genderId: genderId,
    );
    _fetchServices();
  }

  Future<void> refresh() async {
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    if (params == null) {
      return;
    }
    await loadInitialListData(
      ({int? size, int? number}) => _repository.fetchServices(
        params: params,
      ),
    );
  }
}
