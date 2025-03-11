// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_my_services_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MasterMyServicesStateController
    on _MasterMyServicesStateControllerBase, Store {
  late final _$isMainIdAtom = Atom(
      name: '_MasterMyServicesStateControllerBase.isMainId', context: context);

  @override
  int? get isMainId {
    _$isMainIdAtom.reportRead();
    return super.isMainId;
  }

  @override
  set isMainId(int? value) {
    _$isMainIdAtom.reportWrite(value, super.isMainId, () {
      super.isMainId = value;
    });
  }

  late final _$_MasterMyServicesStateControllerBaseActionController =
      ActionController(
          name: '_MasterMyServicesStateControllerBase', context: context);

  @override
  void setMainId(int? value) {
    final _$actionInfo = _$_MasterMyServicesStateControllerBaseActionController
        .startAction(name: '_MasterMyServicesStateControllerBase.setMainId');
    try {
      return super.setMainId(value);
    } finally {
      _$_MasterMyServicesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isMainId: ${isMainId}
    ''';
  }
}
