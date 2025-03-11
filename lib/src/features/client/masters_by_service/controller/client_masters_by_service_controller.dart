import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

import '../../client.dart';

class ClientMastersByServiceController extends BaseController<ClientMasterDto> {
  final _repository = GetIt.instance<ClientMastersByServiceRepository>();

  ClientMastersParams? _params;

  void setupParams(int? serviceId) {
    final masterTypeController = GetIt.instance<MasterTypeController>();
    _params = ClientMastersParams(
      masterTypeId: masterTypeController.currentMasterType.id,
      profileId: serviceId,
    );
  }

  Future<void> fetchMasters() async {
    if (_params == null) {
      return;
    }
    await loadInitialListData(
      ({int? number, int? size}) => _repository.fetchMastersByParams(
        params: _params!,
      ),
    );
  }

  Future<void> fetchMoreMasters([int? serviceId]) async {
    if (_params == null) {
      return;
    }
    await loadMoreListData(
      ({int? number, int? size}) => _repository.fetchMastersByParams(
        params: _params!.copyWith(
          number: number,
          size: size,
        ),
      ),
    );
  }
}
