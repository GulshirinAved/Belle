// ignore_for_file: library_private_types_in_public_api
import 'dart:developer';

import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../../shared.dart';

part 'account_controller.g.dart';

class AccountController = _AccountControllerBase with _$AccountController;

abstract class _AccountControllerBase with Store, HandlingErrorMixin {
  final _repository = GetIt.instance<AccountRepository>();

  final _keyValueStorageService = KeyValueStorageService();
  final _accountLoginStatusController = GetIt.instance<AuthStatusController>();
  final _favoritesStateController =
      GetIt.instance<ClientFavoritesStateController>();
  final _favoritesController = GetIt.instance<ClientFavoritesController>();

  // final _fireMessage = GetIt.instance<FireMessage>();

  @readonly
  ObservableFuture<ObjectResponse<AccountDto?>> _observableAccount =
      ObservableFuture.value(const ObjectResponse(data: null));

  @readonly
  ObservableFuture<void> _firebaseSubscription = ObservableFuture.value(null);

  ReactionDisposer? _disposer;

  @computed
  AccountDto? get accountInfo => _observableAccount.value?.data;

  @computed
  bool get isLoading =>
      _observableAccount.status == FutureStatus.pending ||
      _firebaseSubscription.status == FutureStatus.pending;

  @computed
  bool get isError =>
      _observableAccount.status == FutureStatus.rejected ||
      _firebaseSubscription.status == FutureStatus.rejected;

  @computed
  bool get isSuccess =>
      _observableAccount.status == FutureStatus.fulfilled ||
      _firebaseSubscription.status == FutureStatus.fulfilled;

  // @action
  // Future<void> onAccountUpdate(AccountDto account) async {
  //   _observableAccount = ObservableFuture.value(account);
  //   _account = account;
  //   // await _keyValueStorageService.setAuthUser(account);
  //   await _keyValueStorageService.setAuthPassword(account.password ?? '');
  //   _accountLoginStatusController.getAuthStatus(_observableAccount);
  // }

  // @action
  // Future<void> getAccount() async {
  //   if ((await _keyValueStorageService.getAuthToken()).isEmpty) {
  //     _accountLoginStatusController.getAuthStatus(
  //         ObservableFuture.error(ExceptionType.UnauthorizedException));
  //   } else {
  //     try {
  //       final future = _repository.fetchAccount();
  //
  //       _observableAccount = ObservableFuture(future);
  //       _accountLoginStatusController.getAuthStatus(_observableAccount); // set status to loading
  //
  //       await future.then((response) {
  //         if (response.status == 'error') {
  //           throw Exception(response.message);
  //         }
  //       }).catchError((e) {
  //         log(e.toString());
  //         _observableAccount = ObservableFuture.error(e);
  //         _accountLoginStatusController
  //             .getAuthStatus(_observableAccount); // set status to error
  //       });
  //
  //       _accountLoginStatusController.getAuthStatus(_observableAccount); // set status to success
  //     } catch (e) {
  //       log(e.toString());
  //       _observableAccount = ObservableFuture.error(Exception(e));
  //       _accountLoginStatusController
  //           .getAuthStatus(_observableAccount); // set status to error
  //     }
  //   }
  // }
  @action
  Future<void> getAccount() async {
    if ((await _keyValueStorageService.getAuthToken()).isEmpty) {
      _accountLoginStatusController.getAuthStatus(
        ObservableFuture.error(ExceptionType.UnauthorizedException),
      );
      return;
    }

    try {
      final future = _repository.fetchAccount();
      _observableAccount = ObservableFuture(future);
      _accountLoginStatusController.getAuthStatus(_observableAccount);
      await future.then((value) {
        _accountLoginStatusController.getAuthStatus(_observableAccount);
      });
    } on TokenRevokedException catch (e) {
      log('TokenRevokedException caught: ${e.toString()}');
      logout(() {});
      return;
    } on UnauthorizedException catch (e) {
      log('UnauthorizedException caught: ${e.toString()}');
      logout(() {});
      return;
    } catch (e) {
      log('Account controller | getData | Error: $e');
      _observableAccount = ObservableFuture.error(e);
      _accountLoginStatusController.getAuthStatus(_observableAccount);
    }
  }

  @action
  void setAccount(ObjectResponse<AccountDto> account) {
    _observableAccount = ObservableFuture.value(account);
    _accountLoginStatusController.getAuthStatus(_observableAccount);
  }

  @action
  void deleteAccount(
      VoidCallback successCallback, void Function(dynamic e) errorCallback) {
    // _accountRepository.deleteAccount().then((value) {
    //   _keyValueStorageService.resetKeys();
    //   _accountLoginStatusController.getAuthStatus(
    //     ObservableFuture.error(ExceptionType.UnauthorizedException),
    //   );
    //   successCallback();
    // }).catchError((e) {
    //   errorCallback(e);
    //   log(e.toString());
    // });
  }

  @action
  Future<void> logout(VoidCallback navigateToLogin) async {
    try {
      final fireMessage = GetIt.instance<FireMessage>();
      _firebaseSubscription = ObservableFuture(
        fireMessage.unsubscribeFromTopic(
          await _keyValueStorageService.getAuthToken(),
        ),
      );
      _observableAccount =
          ObservableFuture.value(const ObjectResponse(data: null));
      await Future.wait([
        _keyValueStorageService.resetAuthToken(),
        _keyValueStorageService.resetRefreshToken(),
      ]);
      _accountLoginStatusController.getAuthStatus(
        ObservableFuture.error(ExceptionType.UnauthorizedException),
      );
      _favoritesController.deleteLocalData();
      _favoritesStateController.clearData();
      navigateToLogin();
    } catch (e) {
      log(e.toString());
      handleError(e.toString());
    }
  }

  Future<void> initController() async {
    _disposer ??= reaction((p0) => _observableAccount.value, (p0) {
      _accountLoginStatusController.getAuthStatus(_observableAccount);
    });

    await getAccount();
  }
}
