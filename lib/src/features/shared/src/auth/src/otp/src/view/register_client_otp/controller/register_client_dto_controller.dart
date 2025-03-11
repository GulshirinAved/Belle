import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../../../core/core.dart';
import '../../../../../../../../shared.dart';

class RegisterClientOtpController
    extends OtpController<RegisterClientOtpDto, RegisterClientDto, TokenDto> {
  final _repository = GetIt.instance<OtpRepository>();

  @override
  RegisterClientOtpDto generateOtpModel(String code) {
    return RegisterClientOtpDto(data: data, code: code);
  }

  @override
  Future<ObjectResponse<TokenDto>> makeRequest(RegisterClientOtpDto dto) async {
    return _repository.registerClient(dto);
  }

  @override
  Future<ObjectResponse> resendRequest(RegisterClientDto? dto) {
    final registerOnlyPhoneDto = RegisterOnlyPhoneDto(phone: dto?.phone ?? '');
    return GetIt.instance<RegisterRepository>()
        .registerClient(registerOnlyPhoneDto);
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
