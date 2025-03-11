import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';

import '../../../../../../shared.dart';

abstract class AccountRepository {
  Future<ObjectResponse<AccountDto>> fetchAccount();

  factory AccountRepository(Dio client) => _AccountRepositoryImpl(client);
}

class _AccountRepositoryImpl implements AccountRepository {
  final Dio _client;

  const _AccountRepositoryImpl(this._client);

  @override
  Future<ObjectResponse<AccountDto>> fetchAccount() async {
    final response = await _client.getData<ObjectResponse<AccountDto>>(
      ApiPathHelper.auth(AuthPath.profile),
      converter: (value) => ObjectResponse<AccountDto>.fromJson(
        value,
        AccountDto.fromJson,
      ),
      requiresAuthToken: true,
    );
    return response;
  }
}
