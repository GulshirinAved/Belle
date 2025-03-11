import 'dart:developer';

import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/client/my_bookings/data/dto/client_bookings_dto.dart';
import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../controller/client_my_bookings_controller.dart';

abstract class ClientMyBookingsRepository {
  Future<ListResponse<ClientBookingsDto>> fetchMyBookings(
      {int? size, int? number, ClientBookingType? bookingType});
  Future<ObjectResponse<CalendarResponseModel>> postChosenServicesData(
      ChosenServicesToSendDto? data);

  Future<ObjectResponse> makeBooking(BookingDto data);
  Future<ObjectResponse> changeStatus(
      {required int booking_number, required int status});

  factory ClientMyBookingsRepository(Dio client) =>
      _ClientMyBookingsRepositoryImpl(client);
}

class _ClientMyBookingsRepositoryImpl implements ClientMyBookingsRepository {
  final Dio _client;

  const _ClientMyBookingsRepositoryImpl(this._client);

  @override
  Future<ListResponse<ClientBookingsDto>> fetchMyBookings(
      {int? size,
      int? number,
      ClientBookingType? bookingType = ClientBookingType.active}) async {
    final response = await _client.getData<ListResponse<ClientBookingsDto>>(
      ApiPathHelper.clientBookings(ClientBookingsPath.base),
      converter: (json) =>
          ListResponse.fromJson(json, ClientBookingsDto.fromJson),
      queryParameters: {
        "page": number,
        "per_page": size,
        if (bookingType != null) "parameters": bookingType.name,
      },
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse<CalendarResponseModel>> postChosenServicesData(
      ChosenServicesToSendDto? data) async {
    log('data $data');
    if (data == null) {
      throw 'Data is null';
    }
    final response =
        await _client.postData<ObjectResponse<CalendarResponseModel>>(
      ApiPathHelper.chosenServices(ChosenServicesPath.base),
      data: data.toJson(),
      converter: (json) =>
          ObjectResponse.fromJson(json, CalendarResponseModel.fromJson),
    );
    return response;
  }

  @override
  Future<ObjectResponse> makeBooking(BookingDto data) async {
    final response = await _client.postData(
        ApiPathHelper.createBooking(CreateBookingPath.base),
        data: data.toJson(), converter: (_) {
      return const ObjectResponse();
    });
    return response;
  }

  @override
  Future<ObjectResponse<void>> changeStatus(
      {required int booking_number, required int status}) async {
    final response = await _client.postData(
      ApiPathHelper.personalInfo(
        ClientPersonalBookingPath.status,
      ),
      converter: (_) {
        return const ObjectResponse();
      },
      requiresAuthToken: true,
      data: {
        'booking_number': booking_number,
        'status': status,
      },
    );
    return response;
  }
}
