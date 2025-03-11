import 'dart:developer';

import 'package:belle/src/features/shared/shared.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'role_controller.g.dart';

class RoleController = _RoleController with _$RoleController;

abstract class _RoleController with Store {
  final _accountController = GetIt.instance<AccountController>();

  ReactionDisposer? _disposer;

  void init() {
    _disposer = reaction(
      (p0) => _accountController.accountInfo,
      (accountInfo) {
        log('Role controller | disposer reaction | $accountInfo');
        if (accountInfo == null) {
          setCurrentRole(UserRole.guest);
        } else {
          switch (accountInfo.role?.id) {
            case 4:
              setCurrentRole(UserRole.master);
              break;
            case 5:
              setCurrentRole(UserRole.client);
              break;
            default:
              setCurrentRole(UserRole.guest);
              break;
          }
        }
      },
      fireImmediately: true,
    );
  }

  void dispose() {
    _disposer?.call();
  }

  @observable
  UserRole currentRole = UserRole.guest;

  @action
  void setCurrentRole(UserRole role) {
    currentRole = role;
  }

  @computed
  bool get isGuest => currentRole == UserRole.guest;

  @computed
  bool get isClient => currentRole == UserRole.client;

  @computed
  bool get isMaster => currentRole == UserRole.master;
}
