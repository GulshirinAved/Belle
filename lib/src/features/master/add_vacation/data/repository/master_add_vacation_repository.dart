import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../master.dart';

abstract class MasterAddVacationRepository {
  Future<ObjectResponse> postData(MasterHolidayToSendDto data);
  factory MasterAddVacationRepository(Dio client) =>
      _MasterAddVacationRepositoryImpl(client);
}

class _MasterAddVacationRepositoryImpl implements MasterAddVacationRepository {
  final Dio _client;
  const _MasterAddVacationRepositoryImpl(this._client);

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
}
