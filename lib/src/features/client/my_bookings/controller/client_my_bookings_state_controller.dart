// ignore_for_file: library_private_types_in_public_api

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../utils/utils.dart';

part 'client_my_bookings_state_controller.g.dart';

class ClientMyBookingsStateController = _ClientMyBookingsStateControllerBase
    with _$ClientMyBookingsStateController;

abstract class _ClientMyBookingsStateControllerBase
    with Store, HandlingErrorMixin {
  BuildContext? buildContext;
  @override
  void setContext(BuildContext context) {
    buildContext = context;
  }

  @observable
  ClientBookingType currentBookingType = ClientBookingType.active;

  @observable
  ObservableList<TimeOfDay> selectedSlots = ObservableList<TimeOfDay>();
  @observable
  CalendarResponseModel? responseModel;
  @observable
  ChosenServicesToSendDto? chosenServicesToSendDto;
  @observable
  ClientMasterInfoDto? data;
  @observable
  BookingDto? bookingDto;

  @observable
  int? selectedServiceId;
  @observable
  ObservableList<int?> chosenServices = ObservableList();

  @observable
  ObservableList<Subservice> subservices = ObservableList();

  @observable
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
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
  void changeCurrentBookingType(
      ClientBookingType type, ValueChanged<ClientBookingType> onChanged) {
    if (currentBookingType == type) {
      return;
    }
    currentBookingType = type;
    onChanged(currentBookingType);
  }

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

  BookingDto _generateBookingDto(
      BuildContext context, int? masterId, List<int?>? subserviceIds) {
    final firstSelectedSlot = selectedSlots.first;
    return BookingDto(
      masterId: masterId,
      subserviceIds: subserviceIds,
      bookingLocationId: currentServiceLocationId,
      date:
          DateFormat('yyyy-MM-d', context.loc.localeName).format(selectedDate),
      time: firstSelectedSlot.format(context),
    );
  }

  @action
  BookingDto? handleOnContinue(
      BuildContext context, int? masterId, List<int?>? subserviceIds) {
    bookingDto = _generateBookingDto(context, masterId, subserviceIds);
    return bookingDto;
  }

  Future<T?> _showBottomSheet<T>(
      {required Widget Function(BuildContext) builder}) async {
    if (buildContext == null) {
      throw Exception(
          'BuildContext is not set. Ensure setContext has been called.');
    }
    return await showModalBottomSheet<T?>(
      context: buildContext!,
      useSafeArea: true,
      useRootNavigator: true,
      builder: builder,
    );
  }

  @action
  Future<void> showCancel(final int? bookingNumber) async {
    if (buildContext == null) {
      debugPrint('BuildContext is null. Cannot show bottom sheet.');
      return;
    }
    await _showBottomSheet<Widget?>(
      builder: (context) {
        return CancelBookingWidget(
          bookingNumber: bookingNumber ?? 0,
        );
      },
    );
  }
}
