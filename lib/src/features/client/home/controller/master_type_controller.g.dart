// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_type_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterTypeController on _MasterTypeControllerBase, Store {
  late final _$currentMasterTypeAtom = Atom(
      name: '_MasterTypeControllerBase.currentMasterType', context: context);

  @override
  MasterType get currentMasterType {
    _$currentMasterTypeAtom.reportRead();
    return super.currentMasterType;
  }

  @override
  set currentMasterType(MasterType value) {
    _$currentMasterTypeAtom.reportWrite(value, super.currentMasterType, () {
      super.currentMasterType = value;
    });
  }

  late final _$_MasterTypeControllerBaseActionController =
      ActionController(name: '_MasterTypeControllerBase', context: context);

  @override
  void _getMasterType() {
    final _$actionInfo = _$_MasterTypeControllerBaseActionController
        .startAction(name: '_MasterTypeControllerBase._getMasterType');
    try {
      return super._getMasterType();
    } finally {
      _$_MasterTypeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMasterType(MasterType type) {
    final _$actionInfo = _$_MasterTypeControllerBaseActionController
        .startAction(name: '_MasterTypeControllerBase.setMasterType');
    try {
      return super.setMasterType(type);
    } finally {
      _$_MasterTypeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentMasterType: ${currentMasterType}
    ''';
  }
}
