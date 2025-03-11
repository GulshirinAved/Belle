import 'dart:developer';

import 'package:belle/src/features/client/client.dart';
import 'package:get_it/get_it.dart';
import 'package:belle/src/utils/utils.dart';

class ClientTopStylistsController extends BaseController<ClientMasterDto> {
  final _repository = GetIt.instance<ClientTopStylistsRepository>();

  ClientMastersParams? _params;

  void setupParams() {
    final masterTypeController = GetIt.instance<MasterTypeController>();
    final servicesController = GetIt.instance<ServicesController>();
    _params = ClientMastersParams(
      masterTypeId: masterTypeController.currentMasterType.id,
      profileId: servicesController.items.first.id,
      ranking: ClientMasterRanking.ranking,
    );
  }

  Future<void> fetchMasters([int? serviceId]) async {
    if (_params == null) {
      return;
    }
    if (serviceId != null) {
      _params = _params!.copyWith(
        profileId: serviceId,
      );
    }
    log('Params was changed: ${_params?.toJson()}');
    await loadInitialListData(
      ({int? number, int? size}) => _repository.fetchMastersByParams(
        params: _params!,
      ),
    );
  }

  Future<void> fetchMoreMasters() async {
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
