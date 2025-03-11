// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoleController on _RoleController, Store {
  Computed<bool>? _$isGuestComputed;

  @override
  bool get isGuest => (_$isGuestComputed ??=
          Computed<bool>(() => super.isGuest, name: '_RoleController.isGuest'))
      .value;
  Computed<bool>? _$isClientComputed;

  @override
  bool get isClient =>
      (_$isClientComputed ??= Computed<bool>(() => super.isClient,
              name: '_RoleController.isClient'))
          .value;
  Computed<bool>? _$isMasterComputed;

  @override
  bool get isMaster =>
      (_$isMasterComputed ??= Computed<bool>(() => super.isMaster,
              name: '_RoleController.isMaster'))
          .value;

  late final _$currentRoleAtom =
      Atom(name: '_RoleController.currentRole', context: context);

  @override
  UserRole get currentRole {
    _$currentRoleAtom.reportRead();
    return super.currentRole;
  }

  @override
  set currentRole(UserRole value) {
    _$currentRoleAtom.reportWrite(value, super.currentRole, () {
      super.currentRole = value;
    });
  }

  late final _$_RoleControllerActionController =
      ActionController(name: '_RoleController', context: context);

  @override
  void setCurrentRole(UserRole role) {
    final _$actionInfo = _$_RoleControllerActionController.startAction(
        name: '_RoleController.setCurrentRole');
    try {
      return super.setCurrentRole(role);
    } finally {
      _$_RoleControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentRole: ${currentRole},
isGuest: ${isGuest},
isClient: ${isClient},
isMaster: ${isMaster}
    ''';
  }
}
