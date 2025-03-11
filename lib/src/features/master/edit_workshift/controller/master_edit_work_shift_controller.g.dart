// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_edit_work_shift_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterEditWorkShiftStateController
    on _MasterEditWorkShiftStateController, Store {
  Computed<String>? _$scheduleContentComputed;

  @override
  String get scheduleContent => (_$scheduleContentComputed ??= Computed<String>(
          () => super.scheduleContent,
          name: '_MasterEditWorkShiftStateController.scheduleContent'))
      .value;
  Computed<String>? _$breakTimeContentComputed;

  @override
  String get breakTimeContent => (_$breakTimeContentComputed ??=
          Computed<String>(() => super.breakTimeContent,
              name: '_MasterEditWorkShiftStateController.breakTimeContent'))
      .value;
  Computed<bool>? _$isValidatedComputed;

  @override
  bool get isValidated =>
      (_$isValidatedComputed ??= Computed<bool>(() => super.isValidated,
              name: '_MasterEditWorkShiftStateController.isValidated'))
          .value;

  late final _$selectedDateAtom = Atom(
      name: '_MasterEditWorkShiftStateController.selectedDate',
      context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$rangeStartDateAtom = Atom(
      name: '_MasterEditWorkShiftStateController.rangeStartDate',
      context: context);

  @override
  DateTime? get rangeStartDate {
    _$rangeStartDateAtom.reportRead();
    return super.rangeStartDate;
  }

  @override
  set rangeStartDate(DateTime? value) {
    _$rangeStartDateAtom.reportWrite(value, super.rangeStartDate, () {
      super.rangeStartDate = value;
    });
  }

  late final _$rangeEndDateAtom = Atom(
      name: '_MasterEditWorkShiftStateController.rangeEndDate',
      context: context);

  @override
  DateTime? get rangeEndDate {
    _$rangeEndDateAtom.reportRead();
    return super.rangeEndDate;
  }

  @override
  set rangeEndDate(DateTime? value) {
    _$rangeEndDateAtom.reportWrite(value, super.rangeEndDate, () {
      super.rangeEndDate = value;
    });
  }

  late final _$selectedDaysAtom = Atom(
      name: '_MasterEditWorkShiftStateController.selectedDays',
      context: context);

  @override
  ObservableList<int> get selectedDays {
    _$selectedDaysAtom.reportRead();
    return super.selectedDays;
  }

  @override
  set selectedDays(ObservableList<int> value) {
    _$selectedDaysAtom.reportWrite(value, super.selectedDays, () {
      super.selectedDays = value;
    });
  }

  late final _$chosenStartDateAtom = Atom(
      name: '_MasterEditWorkShiftStateController.chosenStartDate',
      context: context);

  @override
  DateTime? get chosenStartDate {
    _$chosenStartDateAtom.reportRead();
    return super.chosenStartDate;
  }

  @override
  set chosenStartDate(DateTime? value) {
    _$chosenStartDateAtom.reportWrite(value, super.chosenStartDate, () {
      super.chosenStartDate = value;
    });
  }

  late final _$chosenEndDateAtom = Atom(
      name: '_MasterEditWorkShiftStateController.chosenEndDate',
      context: context);

  @override
  DateTime? get chosenEndDate {
    _$chosenEndDateAtom.reportRead();
    return super.chosenEndDate;
  }

  @override
  set chosenEndDate(DateTime? value) {
    _$chosenEndDateAtom.reportWrite(value, super.chosenEndDate, () {
      super.chosenEndDate = value;
    });
  }

  late final _$chosenBreakStartTimeAtom = Atom(
      name: '_MasterEditWorkShiftStateController.chosenBreakStartTime',
      context: context);

  @override
  DateTime? get chosenBreakStartTime {
    _$chosenBreakStartTimeAtom.reportRead();
    return super.chosenBreakStartTime;
  }

  @override
  set chosenBreakStartTime(DateTime? value) {
    _$chosenBreakStartTimeAtom.reportWrite(value, super.chosenBreakStartTime,
        () {
      super.chosenBreakStartTime = value;
    });
  }

  late final _$chosenBreakEndTimeAtom = Atom(
      name: '_MasterEditWorkShiftStateController.chosenBreakEndTime',
      context: context);

  @override
  DateTime? get chosenBreakEndTime {
    _$chosenBreakEndTimeAtom.reportRead();
    return super.chosenBreakEndTime;
  }

  @override
  set chosenBreakEndTime(DateTime? value) {
    _$chosenBreakEndTimeAtom.reportWrite(value, super.chosenBreakEndTime, () {
      super.chosenBreakEndTime = value;
    });
  }

  late final _$selectedLifetimeAtom = Atom(
      name: '_MasterEditWorkShiftStateController.selectedLifetime',
      context: context);

  @override
  LifetimeDto? get selectedLifetime {
    _$selectedLifetimeAtom.reportRead();
    return super.selectedLifetime;
  }

  @override
  set selectedLifetime(LifetimeDto? value) {
    _$selectedLifetimeAtom.reportWrite(value, super.selectedLifetime, () {
      super.selectedLifetime = value;
    });
  }

  late final _$showFrequencyPickerAsyncAction = AsyncAction(
      '_MasterEditWorkShiftStateController.showFrequencyPicker',
      context: context);

  @override
  Future<void> showFrequencyPicker() {
    return _$showFrequencyPickerAsyncAction
        .run(() => super.showFrequencyPicker());
  }

  late final _$showSchedulePickerAsyncAction = AsyncAction(
      '_MasterEditWorkShiftStateController.showSchedulePicker',
      context: context);

  @override
  Future<void> showSchedulePicker() {
    return _$showSchedulePickerAsyncAction
        .run(() => super.showSchedulePicker());
  }

  late final _$showBreakTimePickerAsyncAction = AsyncAction(
      '_MasterEditWorkShiftStateController.showBreakTimePicker',
      context: context);

  @override
  Future<void> showBreakTimePicker() {
    return _$showBreakTimePickerAsyncAction
        .run(() => super.showBreakTimePicker());
  }

  late final _$_MasterEditWorkShiftStateControllerActionController =
      ActionController(
          name: '_MasterEditWorkShiftStateController', context: context);

  @override
  void changeSelectedDate(DateTime date) {
    final _$actionInfo =
        _$_MasterEditWorkShiftStateControllerActionController.startAction(
            name: '_MasterEditWorkShiftStateController.changeSelectedDate');
    try {
      return super.changeSelectedDate(date);
    } finally {
      _$_MasterEditWorkShiftStateControllerActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeRangeDates(DateTime start, DateTime end) {
    final _$actionInfo =
        _$_MasterEditWorkShiftStateControllerActionController.startAction(
            name: '_MasterEditWorkShiftStateController.changeRangeDates');
    try {
      return super.changeRangeDates(start, end);
    } finally {
      _$_MasterEditWorkShiftStateControllerActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void toggleDay(int day) {
    final _$actionInfo = _$_MasterEditWorkShiftStateControllerActionController
        .startAction(name: '_MasterEditWorkShiftStateController.toggleDay');
    try {
      return super.toggleDay(day);
    } finally {
      _$_MasterEditWorkShiftStateControllerActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
rangeStartDate: ${rangeStartDate},
rangeEndDate: ${rangeEndDate},
selectedDays: ${selectedDays},
chosenStartDate: ${chosenStartDate},
chosenEndDate: ${chosenEndDate},
chosenBreakStartTime: ${chosenBreakStartTime},
chosenBreakEndTime: ${chosenBreakEndTime},
selectedLifetime: ${selectedLifetime},
scheduleContent: ${scheduleContent},
breakTimeContent: ${breakTimeContent},
isValidated: ${isValidated}
    ''';
  }
}
