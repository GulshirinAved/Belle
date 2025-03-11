// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../utils/utils.dart';

import 'package:mobx/mobx.dart';

import '../../client.dart';

part 'booking_controller.g.dart';

class BookingController extends BaseController<CalendarResponseModel?> {
  final _repository = GetIt.instance<BookingRepository>();

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

class BookingCalendarController extends BaseController<CalendarResponseModel?> {
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

/// STATE controller
class BookingStateController = _BookingStateControllerBase
    with _$BookingStateController;

abstract class _BookingStateControllerBase with Store, HandlingErrorMixin {
  @observable
  CalendarResponseModel? responseModel;

  @observable
  ObservableList<TimeOfDay> selectedSlots = ObservableList<TimeOfDay>();

  @observable
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @observable
  BookingDto? bookingDto;

  @computed
  List<TimeOfDay> get availableSlots {
    if (responseModel?.calendar?.dates == null ||
        (responseModel?.calendar?.dates?.isEmpty ?? true)) {
      return [];
    }
    return responseModel?.calendar?.dates?.firstWhere(
          (date) {
            final dateOnly = DateTime(date.date?.year ?? 0,
                date.date?.month ?? 0, date.date?.day ?? 0);
            final selectedDateOnly = DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day);

            return dateOnly.compareTo(selectedDateOnly) == 0;
          },
          orElse: () => const DateModel(
            availableSlots: [],
          ),
        ).availableSlots ??
        <TimeOfDay>[];
  }

  @computed
  List<TimeOfDay> get disabledSlots {
    if (responseModel?.calendar?.dates == null ||
        (responseModel?.calendar?.dates?.isEmpty ?? true)) {
      return [];
    }
    return responseModel?.calendar?.dates?.firstWhere(
          (date) {
            final dateOnly = DateTime(date.date?.year ?? 0,
                date.date?.month ?? 0, date.date?.day ?? 0);
            final selectedDateOnly = DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day);

            return dateOnly.compareTo(selectedDateOnly) == 0;
          },
          orElse: () => const DateModel(
            disabledSlots: [],
          ),
        ).disabledSlots ??
        <TimeOfDay>[];
  }

  List<int?>? deleteFromServices(int index) {
    final updatedServices = responseModel?.services;
    updatedServices?.removeAt(index);
    final ids = updatedServices?.map((el) => el.subserviceId).toList();
    return ids;
  }

  List<int?>? getServicesIds() {
    final services = responseModel?.services;
    final ids = services?.map((el) => el.subserviceId).toList();
    return ids;
  }

  @observable
  int currentServiceLocationId = 1;

  @action
  void changeCurrentServiceLocationId(int? id) {
    if (id == null || currentServiceLocationId == id) {
      return;
    }
    currentServiceLocationId = id;
  }

  @action
  void init(CalendarResponseModel? data) {
    responseModel = data;
    selectedDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    selectedSlots.clear();
  }

  @action
  void onSelectDateTap(DateTime date) {
    if (selectedDate == date) {
      return;
    }
    final dateOnly = DateTime(date.year, date.month, date.day);

    selectedDate = dateOnly;
    selectedSlots.clear();
  }

  @action
  void onSelectSlotTap(TimeOfDay time, BuildContext context) {
    if (responseModel == null) {
      return;
    }
    if (responseModel?.calendar?.dates == null ||
        (responseModel?.calendar?.dates?.isEmpty ?? false)) {
      return;
    }

    final servicesOverallTime = responseModel?.totals?.totalTime ?? 0;

    final canSelect = CalculateSelectedTimeService.canSelectTime(
      time,
      servicesOverallTime,
      availableSlots,
      disabledSlots,
    );
    if (!canSelect) {
      _showUnavailableDialog(context);
      return;
    }

    selectedSlots.clear();
    final requiredSlots = (servicesOverallTime / timeIntervalMinutes).ceil();
    final slots = CalculateSelectedTimeService.getAvailableSlots(
      time,
      requiredSlots,
      availableSlots,
      disabledSlots,
    );
    selectedSlots.addAll(slots);
  }

  void _showUnavailableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // TODO: make translations
          title: const Text('Время недоступно'),
          content: const Text(
            'Пожалуйста, выберите другой интервал времени, где подряд доступны все слоты.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('ОК'),
            ),
          ],
        );
      },
    );
  }

  BookingDto _generateBookingDto(BuildContext context, int? masterId) {
    final firstSelectedSlot = selectedSlots.first;
    final bookingDto = BookingDto(
      masterId: masterId,
      subserviceIds: getServicesIds(),
      bookingLocationId: currentServiceLocationId,
      date:
          DateFormat('yyyy-MM-d', context.loc.localeName).format(selectedDate),
      time: firstSelectedSlot.format(context),
    );
    return bookingDto;
  }

  @action
  BookingDto? handleOnContinue(BuildContext context, int? masterId) {
    bookingDto = _generateBookingDto(context, masterId);
    return bookingDto;
  }
}
