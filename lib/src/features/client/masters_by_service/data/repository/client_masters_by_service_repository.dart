import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../client.dart';

abstract class ClientMastersByServiceRepository {
  Future<ListResponse<ClientMasterDto>> fetchMastersByParams({
    required ClientMastersParams params,
  });

  factory ClientMastersByServiceRepository(Dio client) => _ClientMastersByServiceRepositoryImpl(client);

}

class _ClientMastersByServiceRepositoryImpl implements ClientMastersByServiceRepository{
    final Dio _client;
    const _ClientMastersByServiceRepositoryImpl(this._client);

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