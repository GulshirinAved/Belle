// ignore_for_file: library_private_types_in_public_api
import 'package:belle/src/core/core.dart';
import 'package:mobx/mobx.dart';

import '../../client.dart';

part 'master_type_controller.g.dart';

class MasterTypeController = _MasterTypeControllerBase
    with _$MasterTypeController;

abstract class _MasterTypeControllerBase with Store {
  final _keyValueService = KeyValueStorageService();

  @observable
  MasterType currentMasterType = MasterType.women;

  void init() {
    _getMasterType();
  }

  @action
  void _getMasterType() {
    final idFormLocalStorage = _keyValueService.getMasterTypeId();

    currentMasterType =
        MasterType.values.firstWhere((el) => el.id == idFormLocalStorage);
  }

  @action
  void setMasterType(MasterType type) {
    if (currentMasterType == type) {
      return;
    }

    currentMasterType = type;
  }
}
