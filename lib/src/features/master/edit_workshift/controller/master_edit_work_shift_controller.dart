import 'dart:developer';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../utils/utils.dart';
import '../../master.dart';

part 'master_edit_work_shift_controller.g.dart';

class MasterEditWorkShiftController extends BaseController<void> {
  final _repository = GetIt.instance<MasterEditWorkShiftRepository>();

  Future<void> sendData(MasterWorkShiftDto data) async {
    await postData(
      () => _repository.postData(data).then(
        (value) {
          handleSuccess(value.message);
          return value;
        },
      ),
    );
  }

  Future<void> deleteWorkShift(MasterWorkShiftDto data) async {
    await postData(
      () => _repository.deleteData(data.days ?? <int>[]).then(
        (value) {
          handleSuccess(value.message);
          return value;
        },
      ),
    );
  }
}

class MasterEditWorkShiftStateController = _MasterEditWorkShiftStateController
    with _$MasterEditWorkShiftStateController;

abstract class _MasterEditWorkShiftStateController with Store {
  BuildContext? buildContext;
  final _referencesController = GetIt.instance<ReferencesController>();

  void setContext(BuildContext context) {
    buildContext = context;
  }

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  DateTime? rangeStartDate = DateTime.now();

  @observable
  DateTime? rangeEndDate = DateTime.now().add(const Duration(days: 1));

  @observable
  ObservableList<int> selectedDays = ObservableList();

  @observable
  DateTime? chosenStartDate;

  @observable
  DateTime? chosenEndDate;

  @observable
  DateTime? chosenBreakStartTime;

  @observable
  DateTime? chosenBreakEndTime;

  @observable
  LifetimeDto? selectedLifetime;

  void initWorkShift(MasterWorkShiftDto dto) {
    selectedDate = DateTime.parse(dto.startDate!);
    rangeStartDate = DateTime.parse(dto.startDate!);
    rangeEndDate =
        dto.expiresDate != null ? DateTime.parse(dto.expiresDate!) : null;
    selectedDays.addAll(dto.days ?? []);
    if (dto.dayStart != null) {
      chosenStartDate = _parseTime(dto.dayStart!);
    }
    if (dto.dayEnd != null) {
      chosenEndDate = _parseTime(dto.dayEnd!);
    }
    if (dto.breakStart != null) {
      chosenBreakStartTime = _parseTime(dto.breakStart!);
    }
    if (dto.breakEnd != null) {
      chosenBreakEndTime = _parseTime(dto.breakEnd!);
    }
    if (dto.idCWorkshiftLifetime != null) {
      selectedLifetime = _referencesController.data?.lifetimes
          ?.firstWhere((element) => element.id == dto.idCWorkshiftLifetime);
    }
  }

  DateTime _parseTime(String timeString) {
    final now = DateTime.now();
    final timeParts = timeString.split(':');
    final hours = int.parse(timeParts[0]);
    final minutes = int.parse(timeParts[1]);
    return DateTime(now.year, now.month, now.day, hours, minutes);
  }

  @action
  void changeSelectedDate(DateTime date) {
    if (selectedDate == date) {
      return;
    }
    selectedDate = date;
  }

  @action
  void changeRangeDates(DateTime start, DateTime end) {
    rangeStartDate = start;
    rangeEndDate = end;
  }

  @action
  void toggleDay(int day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  @action
  Future<void> showFrequencyPicker() async {
    try {
      final value = await _showBottomSheet<int?>(
        builder: (context) {
          return Observer(builder: (context) {
            return FrequencyPicker(
              onChanged: (value) {
                selectedLifetime = value;
                Navigator.pop(context);
              },
              items: _referencesController.data?.lifetimes,
              selectedItem: selectedLifetime,
            );
          });
        },
      );
      if (value == null) return;
    } catch (e) {
      log(e.toString());
    }
  }

  @action
  Future<void> showSchedulePicker() async {
    try {
      final startTime = await _showTimePicker(
        initialDateTime: chosenStartDate,
        title: buildContext!.loc.choose_schedule_start_time,
      );
      if (startTime == null) return;

      final endTime = await _showTimePicker(
        initialDateTime: chosenEndDate,
        minimumDate: chosenStartDate,
        title: buildContext!.loc.choose_schedule_end_time,
      );
      if (endTime == null) return;
      if (endTime.compareTo(startTime) != 1) {
        return;
      }
      chosenStartDate = startTime;
      chosenEndDate = endTime;
    } catch (e) {
      log(e.toString());
    }
  }

  @action
  Future<void> showBreakTimePicker() async {
    try {
      if (chosenStartDate == null || chosenEndDate == null) {
        ShowSnackHelper.showSnack(buildContext!, SnackStatus.warning,
            buildContext?.loc.choose_schedule_start_time);
        return;
      }
      final startTime = await _showTimePicker(
        initialDateTime: chosenBreakStartTime,
        minimumDate: chosenStartDate,
        maximumDate: chosenEndDate,
        title: buildContext!.loc.choose_break_start_time,
      );
      if (startTime == null) return;

      final endTime = await _showTimePicker(
        initialDateTime: chosenBreakEndTime,
        minimumDate: chosenBreakStartTime,
        maximumDate: chosenEndDate,
        title: buildContext!.loc.choose_break_end_time,
      );
      if (endTime == null) return;
      if (endTime.compareTo(startTime) != 1) {
        return;
      }
      chosenBreakStartTime = startTime;
      chosenBreakEndTime = endTime;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<DateTime?> _showTimePicker({
    DateTime? initialDateTime,
    DateTime? minimumDate,
    DateTime? maximumDate,
    required String title,
  }) async {
    return await _showBottomSheet<DateTime?>(
      builder: (context) {
        return CustomTimePickerWithTitle(
          initialDateTime: initialDateTime,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
          onDateSelected: (value) {},
          title: title,
        );
      },
    );
  }

  Future<T?> _showBottomSheet<T>(
      {required Widget Function(BuildContext) builder}) async {
    return await showModalBottomSheet<T?>(
      context: buildContext!,
      useSafeArea: true,
      useRootNavigator: true,
      builder: builder,
    );
  }

  @computed
  String get scheduleContent => chosenStartDate == null || chosenEndDate == null
      ? ''
      : '${DateFormat.Hm().format(
          chosenStartDate ?? DateTime.now(),
        )} - ${DateFormat.Hm().format(
          chosenEndDate ?? DateTime.now(),
        )}';

  @computed
  String get breakTimeContent =>
      chosenBreakStartTime == null || chosenBreakEndTime == null
          ? ''
          : '${DateFormat.Hm().format(
              chosenBreakStartTime ?? DateTime.now(),
            )} - ${DateFormat.Hm().format(
              chosenBreakEndTime ?? DateTime.now(),
            )}';

  @computed
  bool get isValidated =>
      selectedLifetime != null &&
      selectedDays.isNotEmpty &&
      (chosenStartDate != null && chosenEndDate != null) &&
      (chosenBreakStartTime != null && chosenBreakEndTime != null);

  MasterWorkShiftDto generateData() {
    return MasterWorkShiftDto(
      days: selectedDays,
      idCWorkshiftLifetime: selectedLifetime?.id,
      startDate: DateFormat('yyyy-MM-d', buildContext!.loc.localeName)
          .format(rangeStartDate ?? selectedDate),
      expiresDate: rangeEndDate != null
          ? DateFormat('yyyy-MM-d', buildContext!.loc.localeName)
              .format(rangeEndDate ?? selectedDate)
          : null,
      dayStart: DateFormat.Hm().format(chosenStartDate!),
      dayEnd: DateFormat.Hm().format(chosenEndDate!),
      breakStart: DateFormat.Hm().format(chosenBreakStartTime!),
      breakEnd: DateFormat.Hm().format(chosenBreakEndTime!),
    );
  }
}
