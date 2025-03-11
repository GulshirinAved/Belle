import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';

import '../../../master.dart';

abstract class MasterEditWorkShiftRepository {
  Future<ObjectResponse> postData(MasterWorkShiftDto _);
  Future<ObjectResponse> deleteData(List<int> _);
  factory MasterEditWorkShiftRepository(Dio client) =>
      _MasterEditWorkShiftRepositoryImpl(client);
}

class _MasterEditWorkShiftRepositoryImpl
    implements MasterEditWorkShiftRepository {
  final Dio _client;
  const _MasterEditWorkShiftRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> postData(MasterWorkShiftDto data) async {
    final response = await _client.postData<ObjectResponse>(
      MasterApiPathHelper.workShift(MasterWorkShiftPath.edit),
      converter: (json) => ObjectResponse.fromJson(json),
      data: data.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse> deleteData(List<int> days) async {
    final response = await _client.postData<ObjectResponse>(
      MasterApiPathHelper.workShift(MasterWorkShiftPath.delete),
      converter: (json) => ObjectResponse.fromJson(json),
      data: {'days': days},
      requiresAuthToken: true,
    );
    return response;
  }
}
