// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

import '../../master.dart';

part 'master_edit_client_controller.g.dart';

class MasterEditClientController extends BaseController<void> {
  final _repository = GetIt.instance<MasterClientsRepository>();

  Future<void> editClient({required MasterEditClientDto data}) async {
    await postData(() => _repository.editClient(data: data));
  }
}

class MasterEditClientStateController = _MasterEditClientStateControllerBase
    with _$MasterEditClientStateController;

abstract class _MasterEditClientStateControllerBase
    with Store, HandlingErrorMixin {
  MasterClientDto? _oldData;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  void setData(MasterClientDto data) {
    _oldData = data;
    nameController.text = data.contactName ?? '';
    phoneController.text = data.contactPhone ?? '';
  }

  MasterEditClientDto generateData() {
    return MasterEditClientDto(
      contactName: _oldData?.contactName,
      contactPhone: _oldData?.contactPhone,
      contactOldName: nameController.text,
      contactOldPhone: phoneController.text,
    );
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    disposeContext();
  }
}
