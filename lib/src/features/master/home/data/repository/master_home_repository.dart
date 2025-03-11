import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:dio/dio.dart';

import '../../../api_models/api_models.dart';

abstract class MasterHomeRepository {
  Future<ObjectResponse<MasterCalendarFreeSlotsDto>> fetchFreeSlots();

  Future<ListResponse<MasterCalendarBookingDto>> fetchBookings(
      {required MasterBookingsParams params});

  factory MasterHomeRepository(Dio client) => _MasterHomeRepositoryImpl(client);
}

class _MasterHomeRepositoryImpl implements MasterHomeRepository {
  final Dio _client;

  const _MasterHomeRepositoryImpl(this._client);

  @override
  Future<ListResponse<MasterCalendarBookingDto>> fetchBookings(
      {required MasterBookingsParams params}) async {
    final response = await _client.getData(
      MasterApiPathHelper.bookings(MasterBookingsPath.base),
      converter: (json) =>
          ListResponse.fromJson(json, MasterCalendarBookingDto.fromJson),
      queryParameters: params.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse<MasterCalendarFreeSlotsDto>> fetchFreeSlots() async {
    final response =
        await _client.getData<ObjectResponse<MasterCalendarFreeSlotsDto>>(
      MasterApiPathHelper.freeSlots(MasterFreeSlotsPath.base),
      converter: (json) =>
          ObjectResponse.fromJson(json, MasterCalendarFreeSlotsDto.fromJson),
      // queryParameters: params.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }
}
