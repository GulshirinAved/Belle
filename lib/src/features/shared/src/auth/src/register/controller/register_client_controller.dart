// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../utils/utils.dart';
import '../data/dto/register_client_dto.dart';
import '../data/repository/register_repository.dart';

part 'register_client_controller.g.dart';

class RegisterClientController = _RegisterClientControllerBase
    with _$RegisterClientController;

abstract class _RegisterClientControllerBase with Store, HandlingErrorMixin {
  final _repository = GetIt.instance<RegisterRepository>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @observable
  ObservableFuture<ObjectResponse> _registerResponse =
      ObservableFuture.value(const ObjectResponse());

  @observable
  int gender = 1;

  @observable
  bool agree = false;

  @computed
  bool get isLoading => _registerResponse.status == FutureStatus.pending;

  @computed
  bool get isError => _registerResponse.status == FutureStatus.rejected;

  @action
  void toggleGender(int value) {
    gender = value;
  }

  @action
  void toggleAgree() {
    agree = !agree;
  }

  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  RegisterClientDto generateRegisterModel() {
    final registerDto = RegisterClientDto(
      phone: phoneController.text,
      genderId: gender,
      personFn: nameController.text,
    );
    return registerDto;
  }

  RegisterOnlyPhoneDto generateRegisterOnlyPhoneModel() {
    final registerDto = RegisterOnlyPhoneDto(
      phone: phoneController.text,
    );
    return registerDto;
  }

  @action
  Future<void> registerClient(void Function() successCallback) async {
    try {
      final registerDto = generateRegisterOnlyPhoneModel();
      final future = _repository.registerClient(registerDto);
      _registerResponse = ObservableFuture(future);
      await _registerResponse;
      successCallback();
    } catch (e) {
      debugPrint(e.toString());
      handleError(e.toString());
      _registerResponse = ObservableFuture.error(e);
    }
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
  }
}
