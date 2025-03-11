// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookingStateController on _BookingStateControllerBase, Store {
  Computed<List<TimeOfDay>>? _$availableSlotsComputed;

  @override
  List<TimeOfDay> get availableSlots => (_$availableSlotsComputed ??=
          Computed<List<TimeOfDay>>(() => super.availableSlots,
              name: '_BookingStateControllerBase.availableSlots'))
      .value;
  Computed<List<TimeOfDay>>? _$disabledSlotsComputed;

  @override
  List<TimeOfDay> get disabledSlots => (_$disabledSlotsComputed ??=
          Computed<List<TimeOfDay>>(() => super.disabledSlots,
              name: '_BookingStateControllerBase.disabledSlots'))
      .value;

  late final _$responseModelAtom =
      Atom(name: '_BookingStateControllerBase.responseModel', context: context);

  @override
  CalendarResponseModel? get responseModel {
    _$responseModelAtom.reportRead();
    return super.responseModel;
  }

  @override
  set responseModel(CalendarResponseModel? value) {
    _$responseModelAtom.reportWrite(value, super.responseModel, () {
      super.responseModel = value;
    });
  }

  late final _$selectedSlotsAtom =
      Atom(name: '_BookingStateControllerBase.selectedSlots', context: context);

  @override
  ObservableList<TimeOfDay> get selectedSlots {
    _$selectedSlotsAtom.reportRead();
    return super.selectedSlots;
  }

  @override
  set selectedSlots(ObservableList<TimeOfDay> value) {
    _$selectedSlotsAtom.reportWrite(value, super.selectedSlots, () {
      super.selectedSlots = value;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: '_BookingStateControllerBase.selectedDate', context: context);

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

  late final _$bookingDtoAtom =
      Atom(name: '_BookingStateControllerBase.bookingDto', context: context);

  @override
  BookingDto? get bookingDto {
    _$bookingDtoAtom.reportRead();
    return super.bookingDto;
  }

  @override
  set bookingDto(BookingDto? value) {
    _$bookingDtoAtom.reportWrite(value, super.bookingDto, () {
      super.bookingDto = value;
    });
  }

  late final _$currentServiceLocationIdAtom = Atom(
      name: '_BookingStateControllerBase.currentServiceLocationId',
      context: context);

  @override
  int get currentServiceLocationId {
    _$currentServiceLocationIdAtom.reportRead();
    return super.currentServiceLocationId;
  }

  @override
  set currentServiceLocationId(int value) {
    _$currentServiceLocationIdAtom
        .reportWrite(value, super.currentServiceLocationId, () {
      super.currentServiceLocationId = value;
    });
  }

  late final _$_BookingStateControllerBaseActionController =
      ActionController(name: '_BookingStateControllerBase', context: context);

  @override
  void changeCurrentServiceLocationId(int? id) {
    final _$actionInfo =
        _$_BookingStateControllerBaseActionController.startAction(
            name: '_BookingStateControllerBase.changeCurrentServiceLocationId');
    try {
      return super.changeCurrentServiceLocationId(id);
    } finally {
      _$_BookingStateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void init(CalendarResponseModel? data) {
    final _$actionInfo = _$_BookingStateControllerBaseActionController
        .startAction(name: '_BookingStateControllerBase.init');
    try {
      return super.init(data);
    } finally {
      _$_BookingStateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectDateTap(DateTime date) {
    final _$actionInfo = _$_BookingStateControllerBaseActionController
        .startAction(name: '_BookingStateControllerBase.onSelectDateTap');
    try {
      return super.onSelectDateTap(date);
    } finally {
      _$_BookingStateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectSlotTap(TimeOfDay time, BuildContext context) {
    final _$actionInfo = _$_BookingStateControllerBaseActionController
        .startAction(name: '_BookingStateControllerBase.onSelectSlotTap');
    try {
      return super.onSelectSlotTap(time, context);
    } finally {
      _$_BookingStateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  BookingDto? handleOnContinue(BuildContext context, int? masterId) {
    final _$actionInfo = _$_BookingStateControllerBaseActionController
        .startAction(name: '_BookingStateControllerBase.handleOnContinue');
    try {
      return super.handleOnContinue(context, masterId);
    } finally {
      _$_BookingStateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
responseModel: ${responseModel},
selectedSlots: ${selectedSlots},
selectedDate: ${selectedDate},
bookingDto: ${bookingDto},
currentServiceLocationId: ${currentServiceLocationId},
availableSlots: ${availableSlots},
disabledSlots: ${disabledSlots}
    ''';
  }
}
