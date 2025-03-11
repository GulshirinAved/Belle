import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../../../core/core.dart';
import '../../../../../../../../shared.dart';

class LoginClientOtpController
    extends OtpController<LoginClientOtpDto, LoginClientDto, TokenDto> {
  final _repository = GetIt.instance<OtpRepository>();

  @override
  LoginClientOtpDto generateOtpModel(String code) {
    return LoginClientOtpDto(data: data, code: code);
  }

  @override
  Future<ObjectResponse<TokenDto>> makeRequest(LoginClientOtpDto dto) {
    return _repository.loginClient(dto);
  }

  @override
  Future<ObjectResponse> resendRequest(LoginClientDto? dto) {
    return GetIt.instance<LoginRepository>().loginClient(dto);
  }

  @action
  Future<void> handleOnContinue(String code, VoidCallback onSuccess) async {
    try {
      await makeOtp(code, () async {
        final accountController = GetIt.instance<AccountController>();
        await accountController.getAccount();
        onSuccess();
      });
    } catch (e) {
      handleError(e.toString());
    }
  }
}
