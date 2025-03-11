import 'package:belle/src/features/master/master.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/core.dart';

abstract class MasterServicesRepository {
  Future<ListResponse<ServiceDetailedDto>> fetchServices(
      {MasterSubservicesParams? params});

  factory MasterServicesRepository(Dio client) =>
      _MasterServicesRepositoryImpl(client);
}

class _MasterServicesRepositoryImpl implements MasterServicesRepository {
  final Dio _client;

  const _MasterServicesRepositoryImpl(this._client);

  @override
  Future<ListResponse<ServiceDetailedDto>> fetchServices(
      {MasterSubservicesParams? params}) async {
    final response = await _client.getData(
      MasterApiPathHelper.services(MasterServicesPath.base),
      converter: (json) => ListResponse.fromJson(
        json,
        ServiceDetailedDto.fromJson,
      ),
      queryParameters: params?.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }
}
