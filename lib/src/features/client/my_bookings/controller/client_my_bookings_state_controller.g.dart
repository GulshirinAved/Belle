// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_my_bookings_state_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClientMyBookingsStateController
    on _ClientMyBookingsStateControllerBase, Store {
  Computed<List<TimeOfDay>>? _$availableSlotsComputed;

  @override
  List<TimeOfDay> get availableSlots => (_$availableSlotsComputed ??=
          Computed<List<TimeOfDay>>(() => super.availableSlots,
              name: '_ClientMyBookingsStateControllerBase.availableSlots'))
      .value;
  Computed<List<TimeOfDay>>? _$disabledSlotsComputed;

  @override
  List<TimeOfDay> get disabledSlots => (_$disabledSlotsComputed ??=
          Computed<List<TimeOfDay>>(() => super.disabledSlots,
              name: '_ClientMyBookingsStateControllerBase.disabledSlots'))
      .value;

  late final _$currentBookingTypeAtom = Atom(
      name: '_ClientMyBookingsStateControllerBase.currentBookingType',
      context: context);

  @override
  ClientBookingType get currentBookingType {
    _$currentBookingTypeAtom.reportRead();
    return super.currentBookingType;
  }

  @override
  set currentBookingType(ClientBookingType value) {
    _$currentBookingTypeAtom.reportWrite(value, super.currentBookingType, () {
      super.currentBookingType = value;
    });
  }

  late final _$selectedSlotsAtom = Atom(
      name: '_ClientMyBookingsStateControllerBase.selectedSlots',
      context: context);

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

  late final _$responseModelAtom = Atom(
      name: '_ClientMyBookingsStateControllerBase.responseModel',
      context: context);

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

  late final _$selectedDateAtom = Atom(
      name: '_ClientMyBookingsStateControllerBase.selectedDate',
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

  late final _$currentServiceLocationIdAtom = Atom(
      name: '_ClientMyBookingsStateControllerBase.currentServiceLocationId',
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

  late final _$_ClientMyBookingsStateControllerBaseActionController =
      ActionController(
          name: '_ClientMyBookingsStateControllerBase', context: context);

  @override
  void changeCurrentServiceLocationId(int? id) {
    final _$actionInfo =
        _$_ClientMyBookingsStateControllerBaseActionController.startAction(
            name:
                '_ClientMyBookingsStateControllerBase.changeCurrentServiceLocationId');
    try {
      return super.changeCurrentServiceLocationId(id);
    } finally {
      _$_ClientMyBookingsStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentBookingType(
      ClientBookingType type, ValueChanged<ClientBookingType> onChanged) {
    final _$actionInfo =
        _$_ClientMyBookingsStateControllerBaseActionController.startAction(
            name:
                '_ClientMyBookingsStateControllerBase.changeCurrentBookingType');
    try {
      return super.changeCurrentBookingType(type, onChanged);
    } finally {
      _$_ClientMyBookingsStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void init(CalendarResponseModel? data) {
    final _$actionInfo = _$_ClientMyBookingsStateControllerBaseActionController
        .startAction(name: '_ClientMyBookingsStateControllerBase.init');
    try {
      return super.init(data);
    } finally {
      _$_ClientMyBookingsStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void onSelectDateTap(DateTime date) {
    final _$actionInfo =
        _$_ClientMyBookingsStateControllerBaseActionController.startAction(
            name: '_ClientMyBookingsStateControllerBase.onSelectDateTap');
    try {
      return super.onSelectDateTap(date);
    } finally {
      _$_ClientMyBookingsStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void onSelectSlotTap(TimeOfDay time, BuildContext context) {
    final _$actionInfo =
        _$_ClientMyBookingsStateControllerBaseActionController.startAction(
            name: '_ClientMyBookingsStateControllerBase.onSelectSlotTap');
    try {
      return super.onSelectSlotTap(time, context);
    } finally {
      _$_ClientMyBookingsStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentBookingType: ${currentBookingType},
selectedSlots: ${selectedSlots},
responseModel: ${responseModel},
selectedDate: ${selectedDate},
currentServiceLocationId: ${currentServiceLocationId},
availableSlots: ${availableSlots},
disabledSlots: ${disabledSlots}
    ''';
  }
}
