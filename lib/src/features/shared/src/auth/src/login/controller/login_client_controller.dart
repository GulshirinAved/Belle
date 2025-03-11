// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../utils/utils.dart';
import '../data/dto/login_dto.dart';
import '../data/repository/login_repository.dart';

part 'login_client_controller.g.dart';

class LoginClientController = _LoginClientControllerBase
    with _$LoginClientController;

abstract class _LoginClientControllerBase with Store, HandlingErrorMixin {
  final _repository = GetIt.instance<LoginRepository>();

  final phoneController = TextEditingController();

  @observable
  ObservableFuture<ObjectResponse> _loginResponse =
      ObservableFuture.value(const ObjectResponse());

  @computed
  bool get isLoading => _loginResponse.status == FutureStatus.pending;

  @computed
  bool get isError => _loginResponse.status == FutureStatus.rejected;

  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  LoginClientDto generateLoginModel() {
    final loginDto = LoginClientDto(
      phone: phoneController.text,
    );
    return loginDto;
  }

  @action
  Future<void> loginClient(void Function() successCallback) async {
    try {
      final loginDto = generateLoginModel();
      final future = _repository.loginClient(loginDto);
      _loginResponse = ObservableFuture(future);
      await _loginResponse;
      successCallback();
    } catch (e) {
      debugPrint(e.toString());
      handleError(e.toString());
      _loginResponse = ObservableFuture.error(e);
    }
  }

  void dispose() {
    phoneController.dispose();
  }
}
