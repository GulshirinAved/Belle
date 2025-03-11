import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';

import '../dto/master_edt_service_dto.dart';

abstract class MasterEditServiceRepository {
  Future<ObjectResponse> editService(MasterEditServiceDto? _);

  Future<ObjectResponse> deleteService(int _);

  factory MasterEditServiceRepository(Dio client) =>
      _MasterEditServiceRepositoryImpl(client);
}

class _MasterEditServiceRepositoryImpl implements MasterEditServiceRepository {
  final Dio _client;

  const _MasterEditServiceRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> editService(MasterEditServiceDto? data) async {
    final response = await _client.postData(
      MasterApiPathHelper.service(MasterServicePath.edit),
      converter: (_) => const ObjectResponse(),
      data: data?.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse> deleteService(int id) async {
    final response = await _client.postData(
      MasterApiPathHelper.service(MasterServicePath.delete),
      converter: (_) => const ObjectResponse(),
      data: {'id_master_service': '$id'},
      requiresAuthToken: true,
    );
    return response;
  }
}
