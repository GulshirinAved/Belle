import 'package:belle/src/features/client/client.dart';
import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../master.dart';
import '../dto/master_work_shift_dto.dart';

abstract class MasterWorkShiftRepository {
  Future<ListResponse<MasterWorkShiftDto>> fetchWorkShifts(
      {PaginationParams? params});

  // Future<ObjectResponse> deleteWorkShift({int? id});

  factory MasterWorkShiftRepository(Dio client) =>
      _MasterWorkShiftRepositoryImpl(client);
}

class _MasterWorkShiftRepositoryImpl implements MasterWorkShiftRepository {
  final Dio _client;

  const _MasterWorkShiftRepositoryImpl(this._client);

  @override
  Future<ListResponse<MasterWorkShiftDto>> fetchWorkShifts(
      {PaginationParams? params}) async {
    final response = await _client.getData(
      MasterApiPathHelper.workShifts(MasterWorkShiftsPath.base),
      converter: (json) => ListResponse<MasterWorkShiftDto>.fromJson(
        json,
        MasterWorkShiftDto.fromJson,
      ),
      queryParameters: params?.toJson(),
      requiresAuthToken: true,
    );

    return response;
  }
}
