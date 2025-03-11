// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../shared.dart';

part 'login_master_controller.g.dart';

class LoginMasterController = _LoginMasterControllerBase
    with _$LoginMasterController;

abstract class _LoginMasterControllerBase with Store, HandlingErrorMixin {
  final _repository = GetIt.instance<LoginRepository>();
  final _fireMessage = GetIt.instance<FireMessage>();
  final _keyValueService = KeyValueStorageService();
  final _accountController = GetIt.instance<AccountController>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @observable
  ObservableFuture<ObjectResponse<TokenDto>> _loginResponse =
      ObservableFuture.value(const ObjectResponse());


  @observable
  ObservableFuture<void> _firebaseResponse = ObservableFuture.value(null);

  @computed
  bool get isLoading => _loginResponse.status == FutureStatus.pending || _firebaseResponse.status == FutureStatus.pending;

  @computed
  bool get isError => _loginResponse.status == FutureStatus.rejected || _firebaseResponse.status == FutureStatus.pending;

  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  LoginMasterDto _generateLoginModel() {
    final loginDto = LoginMasterDto(
      phone: phoneController.text,
      password: passwordController.text,
    );
    return loginDto;
  }

  @action
  Future<void> loginMaster(void Function() successCallback) async {
    try {
      final loginDto = _generateLoginModel();
      final future = _repository.loginMaster(loginDto);
      _loginResponse = ObservableFuture(future);

      final response = await _loginResponse;
      if (response.data is TokenDto) {
        final data = response.data as TokenDto;
        await _updateKeyStorage(data);
        await _firebaseSubscription(data.accessToken);
        _accountController.getAccount();
        successCallback();
      } else {
        throw 'Something went wrong';
      }
    } catch (e) {
      debugPrint(e.toString());
      handleError(e.toString());
      _loginResponse = ObservableFuture.error(e);
    }
  }

  Future<void> _updateKeyStorage(TokenDto data) async {
    await _keyValueService.setAuthToken(data.accessToken);
    await _keyValueService.setRefreshToken(data.refreshToken);
  }

  @action
  Future<void> _firebaseSubscription(String accessToken) async {
    try {
      final fireFuture = _fireMessage.subscribeToTopic(accessToken);
      _firebaseResponse = ObservableFuture(fireFuture);
      await _firebaseResponse;
    } catch (e) {
      debugPrint(e.toString());
      handleError(e.toString());
      _firebaseResponse = ObservableFuture.error(e);
    }
  }


  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
  }
}
