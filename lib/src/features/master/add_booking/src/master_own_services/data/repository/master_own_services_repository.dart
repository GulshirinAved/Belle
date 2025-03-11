import 'package:dio/dio.dart';

import '../../../../../../../core/core.dart';
import '../../../../../master.dart';

abstract class MasterOwnServicesRepository {
  Future<ListResponse<MasterOwnServicesDto>> fetchOwnServices({String? time});

  Future<ObjectResponse<void>> postOwnServices(
      {required List<int> services, String? time});

  factory MasterOwnServicesRepository(Dio client) =>
      _MasterOwnServicesRepositoryImpl(client);
}

class _MasterOwnServicesRepositoryImpl implements MasterOwnServicesRepository {
  final Dio _client;

  const _MasterOwnServicesRepositoryImpl(this._client);

  @override
  Future<ListResponse<MasterOwnServicesDto>> fetchOwnServices(
      {String? time}) async {
    final response = await _client.getData(
      MasterApiPathHelper.ownServices(MasterOwnServices.base),
      requiresAuthToken: true,
      queryParameters: {
        if (time != null) "time": time,
      },
      converter: (json) => ListResponse<MasterOwnServicesDto>.fromJson(
          json, MasterOwnServicesDto.fromJson),
    );
    return response;
  }

  @override
  Future<ObjectResponse<void>> postOwnServices(
      {required List<int> services, String? time}) async {
    final response = await _client.postData(
      MasterApiPathHelper.ownServices(MasterOwnServices.base),
      requiresAuthToken: true,
      data: {
        "subservice_ids": services,
        if (time != null) "time": time,
      },
      converter: (json) => const ObjectResponse(),
    );
    return response;
  }
}
