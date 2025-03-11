import 'dart:ui';

import 'package:get_it/get_it.dart';

import '../../../../utils/src/state_manager/state_manager.dart';
import '../../master.dart';

class MasterBookingController extends BaseController<void> {
  final _repository = GetIt.instance<MasterBookingRepository>();

  Future<void> changeStatus(
      String id, int status, VoidCallback onSuccess) async {
    await postData(
      () => _repository.changeBookingStatus(id: id, status: status),
    );
    if (stateManager.isSuccess) {
      onSuccess();
    }
  }
}
