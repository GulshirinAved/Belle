// ignore_for_file: library_private_types_in_public_api
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/core.dart';
import '../../../../../utils/utils.dart';

part 'configuration_controller.g.dart';

class ConfigurationController = _ConfigurationControllerBase
    with _$ConfigurationController;

abstract class _ConfigurationControllerBase with Store, HandlingErrorMixin {
  static const defaultHost = 'external';

  @observable
  String selectedHost = defaultHost;

  @action
  void init() {
    selectedHost = GetIt.instance<KeyValueStorageService>()
            .getValue<String>('selectedHost') ??
        defaultHost;
  }

  @action
  void changeHost(String host) {
    GetIt.instance<KeyValueStorageService>()
        .setValue<String>('selectedHost', host);
    selectedHost = host;
    log(selectedHost);
  }
}
