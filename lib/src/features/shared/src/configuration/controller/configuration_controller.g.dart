// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfigurationController on _ConfigurationControllerBase, Store {
  late final _$selectedHostAtom =
      Atom(name: '_ConfigurationControllerBase.selectedHost', context: context);

  @override
  String get selectedHost {
    _$selectedHostAtom.reportRead();
    return super.selectedHost;
  }

  @override
  set selectedHost(String value) {
    _$selectedHostAtom.reportWrite(value, super.selectedHost, () {
      super.selectedHost = value;
    });
  }

  late final _$_ConfigurationControllerBaseActionController =
      ActionController(name: '_ConfigurationControllerBase', context: context);

  @override
  void init() {
    final _$actionInfo = _$_ConfigurationControllerBaseActionController
        .startAction(name: '_ConfigurationControllerBase.init');
    try {
      return super.init();
    } finally {
      _$_ConfigurationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeHost(String host) {
    final _$actionInfo = _$_ConfigurationControllerBaseActionController
        .startAction(name: '_ConfigurationControllerBase.changeHost');
    try {
      return super.changeHost(host);
    } finally {
      _$_ConfigurationControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedHost: ${selectedHost}
    ''';
  }
}
