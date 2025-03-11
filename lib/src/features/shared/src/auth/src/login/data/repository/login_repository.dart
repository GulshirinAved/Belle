import 'package:dio/dio.dart';

import '../../../../../../../../core/core.dart';
import '../../../../../../shared.dart';

abstract class LoginRepository {
  Future<ObjectResponse> loginClient(LoginClientDto? client);

  Future<ObjectResponse<TokenDto>> loginMaster(LoginMasterDto? master);

  factory LoginRepository(Dio client) => _LoginRepositoryImpl(client);
}

class _LoginRepositoryImpl implements LoginRepository {
  final Dio _client;

  const _LoginRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> loginClient(LoginClientDto? client) {
    final response = _client.postData<ObjectResponse>(
      ApiPathHelper.auth(AuthPath.clientLogin),
      converter: (json) {
        return const ObjectResponse();
      },
      data: client?.toJson(),
    );
    return response;
  }

  @override
  Future<ObjectResponse<TokenDto>> loginMaster(LoginMasterDto? master) {
    final response = _client.postData<ObjectResponse<TokenDto>>(
      ApiPathHelper.auth(AuthPath.masterLogin),
      converter: (json) => ObjectResponse.fromJson(json, TokenDto.fromJson),
      data: master?.toJson(),
    );
    return response;
  }
}
