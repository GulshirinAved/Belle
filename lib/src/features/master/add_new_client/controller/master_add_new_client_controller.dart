// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

import '../../master.dart';

part 'master_add_new_client_controller.g.dart';

class MasterAddNewClientController extends BaseController<void> {
  final _repository = GetIt.instance<MasterClientsRepository>();

  Future<void> addNewClient({required MasterClientDto data}) async {
    await postData(() => _repository.addNewClient(data: data));
  }
}

class MasterAddNewClientStateController = _MasterAddNewClientStateControllerBase
    with _$MasterAddNewClientStateController;

abstract class _MasterAddNewClientStateControllerBase
    with Store, HandlingErrorMixin {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  MasterClientDto generateData() {
    return MasterClientDto(
      contactName: nameController.text,
      contactPhone: phoneController.text,
      contactAddingType: 1,
    );
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    disposeContext();
  }
}
