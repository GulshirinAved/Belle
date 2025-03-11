import 'package:belle/src/features/shared/src/auth/src/otp/otp.dart';
import 'package:dio/dio.dart';

import '../../../../../../../../../core/core.dart';
import '../../../../data/data.dart';

abstract class OtpRepository {
  Future<ObjectResponse<TokenDto>> loginClient(LoginClientOtpDto? data);

  Future<ObjectResponse<TokenDto>> registerClient(RegisterClientOtpDto? data);

  Future<ObjectResponse<TokenDto>> registerMaster(RegisterMasterOtpDto? data);

  factory OtpRepository(Dio client) => _OtpRepositoryImpl(client);
}

class _OtpRepositoryImpl implements OtpRepository {
  final Dio _client;

  const _OtpRepositoryImpl(this._client);

  @override
  Future<ObjectResponse<TokenDto>> loginClient(LoginClientOtpDto? data) async {
    final response = await _client.postData<ObjectResponse<TokenDto>>(
      ApiPathHelper.auth(AuthPath.clientLoginVerify),
      converter: (json) => ObjectResponse.fromJson(json, TokenDto.fromJson),
      data: data?.toJson(),
    );
    return response;
  }

  @override
  Future<ObjectResponse<TokenDto>> registerClient(
      RegisterClientOtpDto? data) async {
    final response = await _client.postData<ObjectResponse<TokenDto>>(
      ApiPathHelper.auth(AuthPath.clientRegisterVerify),
      converter: (json) => ObjectResponse.fromJson(json, TokenDto.fromJson),
      data: data?.toJson(),
    );
    return response;
  }

  @override
  Future<ObjectResponse<TokenDto>> registerMaster(
      RegisterMasterOtpDto? data) async {
    final response = await _client.postData<ObjectResponse<TokenDto>>(
      ApiPathHelper.auth(AuthPath.masterRegisterVerify),
      converter: (json) => ObjectResponse.fromJson(json, TokenDto.fromJson),
      data: data?.toJson(),
    );
    return response;
  }
}
