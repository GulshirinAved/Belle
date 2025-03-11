import 'package:belle/src/features/client/client.dart';
import 'package:dio/dio.dart';

import '../../../../../core/core.dart';

abstract class ClientNewMastersRepository {
  Future<ListResponse<ClientMasterDto>> fetchMastersByParams({
    required ClientMastersParams params,
  });

  factory ClientNewMastersRepository(Dio client) =>
      _ClientNewMastersRepositoryImpl(client);
}

class _ClientNewMastersRepositoryImpl implements ClientNewMastersRepository {
  final Dio _client;

  const _ClientNewMastersRepositoryImpl(this._client);

  @override
  Future<ListResponse<ClientMasterDto>> fetchMastersByParams({
    required ClientMastersParams params,
  }) async {
    final response = await _client.getData<ListResponse<ClientMasterDto>>(
      ApiPathHelper.masters(MastersPath.base),
      queryParameters: params.toJson(),
      converter: (json) => ListResponse<ClientMasterDto>.fromJson(
        json,
        ClientMasterDto.fromJson,
      ),
    );
    return response;
  }
}
