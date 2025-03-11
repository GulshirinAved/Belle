import 'package:dio/dio.dart';

import '../../../../../../../core/core.dart';
import '../dto/master_add_new_service_dto.dart';

abstract class MasterAddNewServiceRepository {
  Future<ObjectResponse> createNewService(MasterAddNewServiceDto data);

  factory MasterAddNewServiceRepository(Dio client) =>
      _MasterAddNewServiceRepositoryImpl(client);
}

class _MasterAddNewServiceRepositoryImpl
    implements MasterAddNewServiceRepository {
  final Dio _client;

  const _MasterAddNewServiceRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> createNewService(MasterAddNewServiceDto data) async {
    final response = await _client.postData(
      MasterApiPathHelper.service(MasterServicePath.create),
      converter: (_) => const ObjectResponse(),
      data: data.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }
}
