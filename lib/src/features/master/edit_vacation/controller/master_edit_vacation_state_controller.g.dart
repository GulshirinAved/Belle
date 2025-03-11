// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_edit_vacation_state_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterEditVacationStateController
    on _MasterEditVacationStateControllerBase, Store {
  late final _$selectedReasonAtom = Atom(
      name: '_MasterEditVacationStateControllerBase.selectedReason',
      context: context);

  @override
  HolidayDto? get selectedReason {
    _$selectedReasonAtom.reportRead();
    return super.selectedReason;
  }

  @override
  set selectedReason(HolidayDto? value) {
    _$selectedReasonAtom.reportWrite(value, super.selectedReason, () {
      super.selectedReason = value;
    });
  }

  late final _$rangeStartDateAtom = Atom(
      name: '_MasterEditVacationStateControllerBase.rangeStartDate',
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
      name: '_MasterEditVacationStateControllerBase.rangeEndDate',
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

  late final _$_MasterEditVacationStateControllerBaseActionController =
      ActionController(
          name: '_MasterEditVacationStateControllerBase', context: context);

  @override
  void changeRangeDates(DateTime start, DateTime end) {
    final _$actionInfo =
        _$_MasterEditVacationStateControllerBaseActionController.startAction(
            name: '_MasterEditVacationStateControllerBase.changeRangeDates');
    try {
      return super.changeRangeDates(start, end);
    } finally {
      _$_MasterEditVacationStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedReason(HolidayDto? data) {
    final _$actionInfo =
        _$_MasterEditVacationStateControllerBaseActionController.startAction(
            name:
                '_MasterEditVacationStateControllerBase.changeSelectedReason');
    try {
      return super.changeSelectedReason(data);
    } finally {
      _$_MasterEditVacationStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedReason: ${selectedReason},
rangeStartDate: ${rangeStartDate},
rangeEndDate: ${rangeEndDate}
    ''';
  }
}
