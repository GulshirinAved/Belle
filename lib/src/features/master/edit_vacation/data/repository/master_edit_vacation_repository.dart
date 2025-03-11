import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../master.dart';

abstract class MasterEditVacationRepository {
  Future<ObjectResponse> postData(MasterHolidayToSendDto _);

  Future<ObjectResponse> deleteData(int _);

  factory MasterEditVacationRepository(Dio client) =>
      _MasterEditVacationRepositoryImpl(client);
}

class _MasterEditVacationRepositoryImpl
    implements MasterEditVacationRepository {
  final Dio _client;

  const _MasterEditVacationRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> postData(MasterHolidayToSendDto data) async {
    final response = await _client.postData<ObjectResponse>(
      MasterApiPathHelper.holiday(MasterHolidayPath.create),
      converter: (json) => ObjectResponse.fromJson(json),
      data: data.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse> deleteData(int id) async {
    final response = await _client.postData<ObjectResponse>(
      MasterApiPathHelper.holiday(MasterHolidayPath.delete),
      converter: (json) => ObjectResponse.fromJson(json),
      data: {"id": id},
      requiresAuthToken: true,
    );
    return response;
  }
}
