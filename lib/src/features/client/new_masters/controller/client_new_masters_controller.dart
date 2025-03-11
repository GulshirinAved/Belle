import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

class ClientNewMastersController extends BaseController<ClientMasterDto> {
  final _repository = GetIt.instance<ClientNewMastersRepository>();

  ClientMastersParams? _params;

  void setupParams() {
    final masterTypeController = GetIt.instance<MasterTypeController>();
    _params = ClientMastersParams(
      masterTypeId: masterTypeController.currentMasterType.id,
      ranking: ClientMasterRanking.newMasters,
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
