import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../core/core.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../../../shared.dart';

import 'package:flutter/foundation.dart';

// Генерация части с MobX
part 'otp_controller_base.g.dart';

// Абстрактный базовый класс без MobX
abstract class OtpControllerBase<TRequestDto, TResendDto, TResult> {
  Future<ObjectResponse<TResult>> makeRequest(TRequestDto dto);

  Future<ObjectResponse> resendRequest(TResendDto? dto);

  TRequestDto generateOtpModel(String code);
}

// Основной класс с MobX
class OtpController<TRequestDto, TResendDto, TResult> = _OtpController<
    TRequestDto, TResendDto, TResult> with _$OtpController;

abstract class _OtpController<TRequestDto, TResendDto, TResult>
    with Store, HandlingErrorMixin
    implements OtpControllerBase<TRequestDto, TResendDto, TResult> {
  @override
  TRequestDto generateOtpModel(String code) {
    throw UnimplementedError(
        'This method should be implemented in the derived class.');
  }

  @override
  Future<ObjectResponse<TResult>> makeRequest(TRequestDto dto) {
    throw UnimplementedError(
        'This method should be implemented in the derived class.');
  }

  @override
  Future<ObjectResponse> resendRequest(TResendDto? dto) {
    throw UnimplementedError(
        'This method should be implemented in the derived class.');
  }

  @observable
  ObservableFuture<ObjectResponse<TResult>?> _response =
      ObservableFuture.value(const ObjectResponse());
  @observable
  ObservableFuture<ObjectResponse?> _resendResponse =
      ObservableFuture.value(const ObjectResponse());
  @observable
  ObservableFuture<void> _firebaseResponse = ObservableFuture.value(null);

  final _accountController = GetIt.instance<AccountController>();

  @computed
  bool get isLoading =>
      _response.status == FutureStatus.pending ||
      _resendResponse.status == FutureStatus.pending ||
      _firebaseResponse.status == FutureStatus.pending;

  @computed
  bool get isError =>
      _response.status == FutureStatus.rejected ||
      _resendResponse.status == FutureStatus.rejected ||
      _firebaseResponse.status == FutureStatus.rejected;

  TResendDto? data;

  void setupData(TResendDto? value) {
    data = value;
  }

  @observable
  String? errorMessage;

  final _keyValueService = KeyValueStorageService();

  @action
  Future<void> makeOtp(String code, void Function() successCallback) async {
    try {
      // final deviceType = await _getDeviceType();
      final otpDto = generateOtpModel(code);
      final future = makeRequest(otpDto);
      _response = ObservableFuture(future);
      final response = await _response;
      if (response?.data is TokenDto) {
        final data = response?.data as TokenDto;
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
      _response = ObservableFuture.error(e);
    }
  }

  Future<void> _updateKeyStorage(TokenDto data) async {
    await _keyValueService.setAuthToken(data.accessToken);
    await _keyValueService.setRefreshToken(data.refreshToken);
  }

  @action
  Future<void> _firebaseSubscription(String accessToken) async {
    try {
      final fireMessage = GetIt.instance<FireMessage>();
      final fireFuture = fireMessage.subscribeToTopic(accessToken);
      _firebaseResponse = ObservableFuture(fireFuture);
      await _firebaseResponse;
    } catch (e) {
      debugPrint(e.toString());
      handleError(e.toString());
      _firebaseResponse = ObservableFuture.error(e);
    }
  }

  @action
  Future<void> resendCode() async {
    try {
      final future = resendRequest(data);
      _resendResponse = ObservableFuture(future);
    } catch (e) {
      debugPrint(e.toString());
      handleError(e.toString());
      _resendResponse = ObservableFuture.error(e);
    }
  }
}
