import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../../../core/core.dart';
import '../../../../../../../../shared.dart';

class RegisterMasterOtpController extends OtpController<RegisterMasterOtpDto, RegisterMasterDto, TokenDto> {
  final _repository = GetIt.instance<OtpRepository>();

  @override
  RegisterMasterOtpDto generateOtpModel(String code) {
    return RegisterMasterOtpDto(data: data, code: code);
  }

  @override
  Future<ObjectResponse<TokenDto>> makeRequest(RegisterMasterOtpDto dto) {
    return _repository.registerMaster(dto);
  }

  @override
  Future<ObjectResponse> resendRequest(RegisterMasterDto? dto) {
    final registerOnlyPhoneDto = RegisterOnlyPhoneDto(phone: dto?.phone ?? '');
    return GetIt.instance<RegisterRepository>().registerMaster(registerOnlyPhoneDto);
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