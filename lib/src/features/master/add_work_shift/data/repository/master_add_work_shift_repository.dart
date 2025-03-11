import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';

import '../../../master.dart';

abstract class MasterAddWorkShiftRepository {
  Future<ObjectResponse> postData(MasterWorkShiftDto data);
  factory MasterAddWorkShiftRepository(Dio client) =>
      _MasterAddWorkShiftRepositoryImpl(client);
}

class _MasterAddWorkShiftRepositoryImpl
    implements MasterAddWorkShiftRepository {
  final Dio _client;
  const _MasterAddWorkShiftRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> postData(MasterWorkShiftDto data) async {
    final response = await _client.postData<ObjectResponse>(
      MasterApiPathHelper.workShift(MasterWorkShiftPath.create),
      converter: (json) => ObjectResponse.fromJson(json),
      data: data.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }
}
