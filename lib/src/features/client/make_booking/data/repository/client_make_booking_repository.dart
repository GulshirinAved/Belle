import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';

import '../dto/booking_dto.dart';

abstract class ClientMakeBookingRepository {
  Future<ObjectResponse> makeBooking(BookingDto data);

  factory ClientMakeBookingRepository(Dio client) =>
      _ClientMakeBookingRepositoryImpl(client);
}

class _ClientMakeBookingRepositoryImpl implements ClientMakeBookingRepository {
  final Dio _client;

  const _ClientMakeBookingRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> makeBooking(BookingDto data) async {
    final response = await _client.postData(
      ApiPathHelper.createBooking(CreateBookingPath.base),
      data: data.toJson(),
      converter: (_) {
        return const ObjectResponse();
      }
    );
    return response;
  }
}
