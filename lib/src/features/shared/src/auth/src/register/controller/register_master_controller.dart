// ignore_for_file: library_private_types_in_public_api
import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/shared/src/auth/src/register/data/dto/register_client_dto.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../utils/utils.dart';
import '../data/repository/register_repository.dart';

part 'register_master_controller.g.dart';

class RegisterMasterController = _RegisterMasterControllerBase
    with _$RegisterMasterController;

abstract class _RegisterMasterControllerBase with Store, HandlingErrorMixin {
  final _repository = GetIt.instance<RegisterRepository>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final workingLocations = WorkingLocationLocal.workingLocations;

  @observable
  ObservableFuture<ObjectResponse> _registerResponse =
      ObservableFuture.value(const ObjectResponse());

  @observable
  ObservableList<int> selectedWorkingLocations = ObservableList();

  @observable
  ClientServiceDto? selectedService;

  @observable
  int gender = 1;

  @observable
  bool agree = false;

  @computed
  bool get isLoading => _registerResponse.status == FutureStatus.pending;

  @computed
  bool get isError => _registerResponse.status == FutureStatus.rejected;

  @action
  void changeSelectedService(ClientServiceDto service) {
    if (selectedService == service) {
      return;
    }
    selectedService = service;
  }

  @action
  void toggleGender(int value) {
    gender = value;
  }

  @action
  void toggleSelectedWorkingLocation(int id) {
    selectedWorkingLocations.changeState(id);
  }

  @action
  void toggleAgree() {
    agree = !agree;
  }

  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  RegisterMasterDto generateRegisterModel() {
    final registerDto = RegisterMasterDto(
      phone: phoneController.text,
      genderId: gender,
      personFn: firstNameController.text,
      personLn: lastNameController.text,
      password: passwordController.text,
      workingLocationIds: selectedWorkingLocations,
      serviceId: selectedService?.id,
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
  Future<void> registerMaster(VoidCallback successCallback) async {
    try {
      final registerDto = generateRegisterOnlyPhoneModel();
      final future = _repository.registerMaster(registerDto);
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
    firstNameController.dispose();
    phoneController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
  }
}
