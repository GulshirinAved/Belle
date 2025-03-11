import 'package:belle/src/features/client/client.dart';
import 'package:dio/dio.dart';

import '../../../../../core/core.dart';

abstract class ClientTopStylistsRepository {
  Future<ListResponse<ClientMasterDto>> fetchMastersByParams({
    required ClientMastersParams params,
  });

  factory ClientTopStylistsRepository(Dio client) =>
      _ClientTopStylistsRepositoryImpl(client);
}

class _ClientTopStylistsRepositoryImpl implements ClientTopStylistsRepository {
  final Dio _client;

  const _ClientTopStylistsRepositoryImpl(this._client);

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
