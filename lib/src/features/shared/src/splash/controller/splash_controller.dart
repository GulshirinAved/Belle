import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer';

import '../../../shared.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  final _roleController = GetIt.instance<RoleController>();
  final _authStatusController = GetIt.instance<AuthStatusController>();
  final _referencesController = GetIt.instance<ReferencesController>();
  final List<ReactionDisposer> _disposers = [];

  @observable
  bool isAuthStatusReady = false;

  @observable
  bool isReferencesReady = false;

  @action
  Future<void> initializeApp(
      VoidCallback navigateToMaster, VoidCallback navigateToClient) async {
    try {
      await _referencesController.fetchReferences();
    } catch (e) {}

    final value = _authStatusController.authLoginStatus;

    if (value != AuthLoginStatus.error && value != AuthLoginStatus.loading) {
      isAuthStatusReady = true;
    }

    if (_referencesController.stateManager.isSuccess) {
      isReferencesReady = true;
    }
    _checkAndNavigate(navigateToMaster, navigateToClient);
    _disposers.add(reaction(
      (_) => _authStatusController.authLoginStatus,
      (value) {
        if (value != AuthLoginStatus.error &&
            value != AuthLoginStatus.loading) {
          isAuthStatusReady = true;
          _checkAndNavigate(navigateToMaster, navigateToClient);
        } else {
          isAuthStatusReady = false;
        }
      },
    ));

    _disposers.add(reaction(
      (_) => _referencesController.stateManager.isSuccess,
      (value) {
        if (value) {
          isReferencesReady = true;
          _checkAndNavigate(navigateToMaster, navigateToClient);
        } else {
          isReferencesReady = false;
        }
      },
    ));
  }

  void _checkAndNavigate(
      VoidCallback navigateToMaster, VoidCallback navigateToClient) {
    if (isAuthStatusReady && isReferencesReady) {
      _navigateBasedOnRole(navigateToMaster, navigateToClient);
    }
  }

  void _navigateBasedOnRole(
      VoidCallback navigateToMaster, VoidCallback navigateToClient) {
    try {
      if (_roleController.isMaster) {
        navigateToMaster();
      } else if (_roleController.isClient || _roleController.isGuest) {
        navigateToClient();
      }
    } catch (e) {
      log('Ошибка загрузки аккаунта: $e');
      _roleController.setCurrentRole(UserRole.guest);
      navigateToClient();
    }
  }

  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    _disposers.clear();
  }
}
