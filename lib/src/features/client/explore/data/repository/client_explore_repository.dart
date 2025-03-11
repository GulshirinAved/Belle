import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../api_models/src/client_masters_params.dart';
import '../../../home/data/dto/client_master_dto.dart';

abstract class ClientExploreRepository {
  Future<ListResponse<ClientMasterDto>> fetchMasters({
    required ClientMastersParams params,
  });

  factory ClientExploreRepository(Dio client) =>
      _ClientExploreRepositoryImpl(client);
}

class _ClientExploreRepositoryImpl implements ClientExploreRepository {
  final Dio _client;

  const _ClientExploreRepositoryImpl(this._client);

  @override
  Future<ListResponse<ClientMasterDto>> fetchMasters(
      {required ClientMastersParams params,}) async {
    final response = await _client.getData(
      ApiPathHelper.masters(MastersPath.base),
      queryParameters: params.toJson(),
      converter: (json) => ListResponse<ClientMasterDto>.fromJson(
          json, ClientMasterDto.fromJson),
    );
    return response;
  }
}
