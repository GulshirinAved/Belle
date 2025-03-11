import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../../client/client.dart';
import '../../../master.dart';

abstract class MasterHolidaysRepository {
  Future<ListResponse<MasterHolidayDto>> fetchHolidays(
      {PaginationParams? params});

  factory MasterHolidaysRepository(Dio client) =>
      _MasterHolidaysRepositoryImpl(client);
}

class _MasterHolidaysRepositoryImpl implements MasterHolidaysRepository {
  final Dio _client;

  const _MasterHolidaysRepositoryImpl(this._client);

  @override
  Future<ListResponse<MasterHolidayDto>> fetchHolidays(
      {PaginationParams? params}) async {
    final response = await _client.getData(
      MasterApiPathHelper.holidays(MasterHolidaysPath.base),
      converter: (json) => ListResponse<MasterHolidayDto>.fromJson(
        json,
        MasterHolidayDto.fromJson,
      ),
      queryParameters: params?.toJson(),
      requiresAuthToken: true,
    );

    return response;
  }
}
