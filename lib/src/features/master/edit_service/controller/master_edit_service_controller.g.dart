// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_edit_service_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterEditServiceStateController
    on _MasterEditServiceStateControllerBase, Store {
  late final _$chosenSubserviceAtom = Atom(
      name: '_MasterEditServiceStateControllerBase.chosenSubservice',
      context: context);

  @override
  SubserviceDto? get chosenSubservice {
    _$chosenSubserviceAtom.reportRead();
    return super.chosenSubservice;
  }

  @override
  set chosenSubservice(SubserviceDto? value) {
    _$chosenSubserviceAtom.reportWrite(value, super.chosenSubservice, () {
      super.chosenSubservice = value;
    });
  }

  late final _$subserviceDurationAtom = Atom(
      name: '_MasterEditServiceStateControllerBase.subserviceDuration',
      context: context);

  @override
  int? get subserviceDuration {
    _$subserviceDurationAtom.reportRead();
    return super.subserviceDuration;
  }

  @override
  set subserviceDuration(int? value) {
    _$subserviceDurationAtom.reportWrite(value, super.subserviceDuration, () {
      super.subserviceDuration = value;
    });
  }

  late final _$isPriceFixedAtom = Atom(
      name: '_MasterEditServiceStateControllerBase.isPriceFixed',
      context: context);

  @override
  bool get isPriceFixed {
    _$isPriceFixedAtom.reportRead();
    return super.isPriceFixed;
  }

  @override
  set isPriceFixed(bool value) {
    _$isPriceFixedAtom.reportWrite(value, super.isPriceFixed, () {
      super.isPriceFixed = value;
    });
  }

  late final _$_MasterEditServiceStateControllerBaseActionController =
      ActionController(
          name: '_MasterEditServiceStateControllerBase', context: context);

  @override
  void togglePriceFixed(bool value) {
    final _$actionInfo =
        _$_MasterEditServiceStateControllerBaseActionController.startAction(
            name: '_MasterEditServiceStateControllerBase.togglePriceFixed');
    try {
      return super.togglePriceFixed(value);
    } finally {
      _$_MasterEditServiceStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeSubserviceDuration(int value) {
    final _$actionInfo =
        _$_MasterEditServiceStateControllerBaseActionController.startAction(
            name:
                '_MasterEditServiceStateControllerBase.changeSubserviceDuration');
    try {
      return super.changeSubserviceDuration(value);
    } finally {
      _$_MasterEditServiceStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chosenSubservice: ${chosenSubservice},
subserviceDuration: ${subserviceDuration},
isPriceFixed: ${isPriceFixed}
    ''';
  }
}
