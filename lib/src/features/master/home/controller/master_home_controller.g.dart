// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterHomeStateController on _MasterHomeStateControllerBase, Store {
  late final _$selectedDateAtom = Atom(
      name: '_MasterHomeStateControllerBase.selectedDate', context: context);

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

  late final _$_MasterHomeStateControllerBaseActionController =
      ActionController(
          name: '_MasterHomeStateControllerBase', context: context);

  @override
  void changeSelectedDate(DateTime date) {
    final _$actionInfo = _$_MasterHomeStateControllerBaseActionController
        .startAction(name: '_MasterHomeStateControllerBase.changeSelectedDate');
    try {
      return super.changeSelectedDate(date);
    } finally {
      _$_MasterHomeStateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate}
    ''';
  }
}
