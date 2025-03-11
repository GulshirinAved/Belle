import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../client.dart';

abstract class ClientHomeRepository {
  Future<ListResponse<ClientServiceDto>> fetchServices(
      {required ClientServicesParams params});

  Future<ListResponse<ClientMasterDto>> fetchNewMasters(
      {required ClientMastersParams params});

  Future<ListResponse<ClientMasterDto>> fetchTopStylists(
      {required ClientMastersParams params});

  factory ClientHomeRepository(Dio client) => _ClientHomeRepositoryImpl(client);
}

class _ClientHomeRepositoryImpl implements ClientHomeRepository {
  final Dio _client;

  const _ClientHomeRepositoryImpl(this._client);

  @override
  Future<ListResponse<ClientServiceDto>> fetchServices(
      {required ClientServicesParams params}) async {
    final response = await _client.getData(
      ApiPathHelper.services(ClientServicesPath.base),
      queryParameters: params.toJson(),
      converter: (json) => ListResponse<ClientServiceDto>.fromJson(
          json, ClientServiceDto.fromJson),
    );
    return response;
  }

  @override
  Future<ListResponse<ClientMasterDto>> fetchNewMasters(
      {required ClientMastersParams params}) async {
    final response = await _client.getData(
      ApiPathHelper.masters(MastersPath.base),
      queryParameters: params.toJson(),
      converter: (json) => ListResponse<ClientMasterDto>.fromJson(
          json, ClientMasterDto.fromJson),
    );
    return response;
  }

  @override
  Future<ListResponse<ClientMasterDto>> fetchTopStylists(
      {required ClientMastersParams params}) async {
    final response = await _client.getData(
      ApiPathHelper.masters(MastersPath.base),
      queryParameters: params.toJson(),
      converter: (json) => ListResponse<ClientMasterDto>.fromJson(
          json, ClientMasterDto.fromJson),
    );
    return response;
  }
}