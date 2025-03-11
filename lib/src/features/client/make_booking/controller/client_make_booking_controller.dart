import 'package:belle/src/features/client/make_booking/data/repository/client_make_booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:belle/src/utils/utils.dart';

import '../data/dto/booking_dto.dart';

class ClientMakeBookingController extends BaseController<void> {
  final _repository = GetIt.instance<ClientMakeBookingRepository>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  void initWithAccountData(String phone, String name) {
    nameController.text = name;
    phoneController.text = phone;
  }

  Future<void> makeBooking(BookingDto? bookingDto) async {
    if (bookingDto == null) {
      return;
    }
    await postData(
      () => _repository.makeBooking(bookingDto),
    );
  }

  void dispose() {
    disposeContext();
    nameController.dispose();
    phoneController.dispose();
  }
}
