// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_choose_date_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterChosenServicesStateController
    on _MasterChosenServicesStateControllerBase, Store {
  Computed<List<TimeOfDay>>? _$availableSlotsComputed;

  @override
  List<TimeOfDay> get availableSlots => (_$availableSlotsComputed ??=
          Computed<List<TimeOfDay>>(() => super.availableSlots,
              name: '_MasterChosenServicesStateControllerBase.availableSlots'))
      .value;
  Computed<List<TimeOfDay>>? _$disabledSlotsComputed;

  @override
  List<TimeOfDay> get disabledSlots => (_$disabledSlotsComputed ??=
          Computed<List<TimeOfDay>>(() => super.disabledSlots,
              name: '_MasterChosenServicesStateControllerBase.disabledSlots'))
      .value;

  late final _$responseModelAtom = Atom(
      name: '_MasterChosenServicesStateControllerBase.responseModel',
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

  late final _$selectedSlotsAtom = Atom(
      name: '_MasterChosenServicesStateControllerBase.selectedSlots',
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

  late final _$selectedDateAtom = Atom(
      name: '_MasterChosenServicesStateControllerBase.selectedDate',
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

  late final _$bookingDtoAtom = Atom(
      name: '_MasterChosenServicesStateControllerBase.bookingDto',
      context: context);

  @override
  MasterCreateBookingDto? get bookingDto {
    _$bookingDtoAtom.reportRead();
    return super.bookingDto;
  }

  @override
  set bookingDto(MasterCreateBookingDto? value) {
    _$bookingDtoAtom.reportWrite(value, super.bookingDto, () {
      super.bookingDto = value;
    });
  }

  late final _$currentServiceLocationIdAtom = Atom(
      name: '_MasterChosenServicesStateControllerBase.currentServiceLocationId',
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

  late final _$_MasterChosenServicesStateControllerBaseActionController =
      ActionController(
          name: '_MasterChosenServicesStateControllerBase', context: context);

  @override
  void changeCurrentServiceLocationId(int? id) {
    final _$actionInfo =
        _$_MasterChosenServicesStateControllerBaseActionController.startAction(
            name:
                '_MasterChosenServicesStateControllerBase.changeCurrentServiceLocationId');
    try {
      return super.changeCurrentServiceLocationId(id);
    } finally {
      _$_MasterChosenServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void init(CalendarResponseModel? data) {
    final _$actionInfo =
        _$_MasterChosenServicesStateControllerBaseActionController.startAction(
            name: '_MasterChosenServicesStateControllerBase.init');
    try {
      return super.init(data);
    } finally {
      _$_MasterChosenServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void onSelectDateTap(DateTime date) {
    final _$actionInfo =
        _$_MasterChosenServicesStateControllerBaseActionController.startAction(
            name: '_MasterChosenServicesStateControllerBase.onSelectDateTap');
    try {
      return super.onSelectDateTap(date);
    } finally {
      _$_MasterChosenServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void onSelectSlotTap(TimeOfDay time, BuildContext context) {
    final _$actionInfo =
        _$_MasterChosenServicesStateControllerBaseActionController.startAction(
            name: '_MasterChosenServicesStateControllerBase.onSelectSlotTap');
    try {
      return super.onSelectSlotTap(time, context);
    } finally {
      _$_MasterChosenServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  MasterCreateBookingDto? handleOnContinue(BuildContext context) {
    final _$actionInfo =
        _$_MasterChosenServicesStateControllerBaseActionController.startAction(
            name: '_MasterChosenServicesStateControllerBase.handleOnContinue');
    try {
      return super.handleOnContinue(context);
    } finally {
      _$_MasterChosenServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
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
