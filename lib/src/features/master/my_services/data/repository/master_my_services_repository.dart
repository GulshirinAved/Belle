import 'package:belle/src/features/client/client.dart';
import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../master.dart';

abstract class MasterMyServicesRepository {
  Future<ListResponse<MasterServiceDto>> fetchMasterServices(
      {PaginationParams? params});

  Future<ObjectResponse> saveMainService({int? id});

  factory MasterMyServicesRepository(Dio client) =>
      _MasterMyServicesRepositoryImpl(client);
}

class _MasterMyServicesRepositoryImpl implements MasterMyServicesRepository {
  final Dio _client;

  const _MasterMyServicesRepositoryImpl(this._client);

  @override
  Future<ListResponse<MasterServiceDto>> fetchMasterServices(
      {PaginationParams? params}) async {
    final response = await _client.getData(
      MasterApiPathHelper.services(MasterServicesPath.masterServices),
      converter: (json) => ListResponse.fromJson(
        json,
        MasterServiceDto.fromJson,
      ),
      queryParameters: params?.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse> saveMainService({int? id}) async {
    final response = await _client.postData(
      MasterApiPathHelper.services(MasterServicesPath.chooseMainService),
      converter: (json) => ObjectResponse.fromJson(json),
      data: {
        "id_c_subservice": id,
      },
      requiresAuthToken: true,
    );
    return response;
  }
}
