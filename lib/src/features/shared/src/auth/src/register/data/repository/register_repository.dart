import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/src/auth/src/register/data/dto/register_client_dto.dart';
import 'package:dio/dio.dart';

abstract class RegisterRepository {
  Future<ObjectResponse> registerClient(RegisterOnlyPhoneDto? client);

  Future<ObjectResponse> registerMaster(RegisterOnlyPhoneDto? master);

  factory RegisterRepository(Dio client) => _RegisterRepositoryImpl(client);
}

class _RegisterRepositoryImpl implements RegisterRepository {
  final Dio _client;

  const _RegisterRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> registerClient(RegisterOnlyPhoneDto? client) {
    final response = _client.postData<ObjectResponse>(
      ApiPathHelper.auth(AuthPath.clientRegister),
      converter: (json) {
        return const ObjectResponse();
      },
      data: client?.toJson(),
    );
    return response;
  }

  @override
  Future<ObjectResponse> registerMaster(RegisterOnlyPhoneDto? master) {
    final response = _client.postData<ObjectResponse>(
      ApiPathHelper.auth(AuthPath.masterRegister),
      converter: (json) {
        return const ObjectResponse();
      },
      data: master?.toJson(),
    );
    return response;
  }
}
