import 'dart:developer';

import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/client/my_bookings/data/dto/client_bookings_dto.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../data/repository/client_my_bookings_repository.dart';

class ClientMyBookingsController extends BaseController<ClientBookingsDto> {
  final _repository = GetIt.instance<ClientMyBookingsRepository>();

  Future<void> fetchMyBookings([ClientBookingType? bookingType]) async {
    await loadInitialListData(({size, number}) => _repository.fetchMyBookings(
        size: size, number: number, bookingType: bookingType));
  }

  Future<void> paginateMyBookings([ClientBookingType? bookingType]) async {
    await loadMoreListData(({size, number}) => _repository.fetchMyBookings(
        size: size, number: number, bookingType: bookingType));
  }

  Future<void> makeBooking(BookingDto? bookingDto) async {
    if (bookingDto == null) {
      return;
    }
    await postData(
      () => _repository.makeBooking(bookingDto),
    );
  }
}

class ClientBookingMasterInfoController
    extends BaseController<ClientMasterInfoDto> {
  final _repository = GetIt.instance<ClientMasterInfoRepository>();
  Future<void> fetchMasterInfo(int? id, VoidCallback onSuccess) async {
    await fetchData(() => _repository.fetchMasterInfo(id: id));
    onSuccess();
    log('id:$id, ${_repository.fetchMasterInfo(id: id)}');
  }
}

class ClientBookingCalendarController
    extends BaseController<CalendarResponseModel?> {
  final _repository = GetIt.instance<BookingRepository>();

  void init(CalendarResponseModel? newData) {
    setData(newData);
  }

  Future<void> postChosenServices(ChosenServicesToSendDto? data,
      void Function(CalendarResponseModel?) onSuccess) async {
    await postData<CalendarResponseModel?>(
      () async {
        final response = await _repository.postChosenServicesData(data);
        onSuccess(response.data);
        return response;
      },
    );
  }
}

class ClientBookingStatusController extends BaseController<void> {
  final _repository = GetIt.instance<ClientMyBookingsRepository>();

  Future<void> changeStatus(
      int bookingNumber, int status, VoidCallback onSuccess) async {
    await postData(
      () => _repository.changeStatus(
          booking_number: bookingNumber, status: status),
    );
    if (stateManager.isSuccess) {
      onSuccess();
    }
  }
}

enum ClientBookingType {
  active,
  history,
}
