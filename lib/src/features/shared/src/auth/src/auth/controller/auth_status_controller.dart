import 'dart:developer';

import 'package:belle/src/core/core.dart';
import 'package:mobx/mobx.dart';

part 'auth_status_controller.g.dart';

enum AuthLoginStatus { error, loggedIn, notLoggedIn, loading, empty }

class AuthStatusController = _AuthStatusControllerBase
    with _$AuthStatusController;

abstract class _AuthStatusControllerBase with Store {
  @observable
  AuthLoginStatus authLoginStatus = AuthLoginStatus.loading;

  @action
  void getAuthStatus(ObservableFuture authResponse) {
    final status = authResponse.status;
    AuthLoginStatus updateLoginStatus;
    switch (status) {
      case FutureStatus.fulfilled:
        if (authResponse.value?.status == 'error') {
          updateLoginStatus = AuthLoginStatus.error;
          log('Server Error: ${authResponse.value?.message}');
        } else {
          updateLoginStatus = AuthLoginStatus.loggedIn;
        }
        break;
      case FutureStatus.pending:
        updateLoginStatus = AuthLoginStatus.loading;
        break;
      case FutureStatus.rejected:
        if (authResponse.error == ExceptionType.UnauthorizedException) {
          updateLoginStatus = AuthLoginStatus.notLoggedIn;
        } else {
          updateLoginStatus = AuthLoginStatus.error;
        }
        break;
      // default:
      //   updateLoginStatus = AuthLoginStatus.empty;
      //   break;
    }
    if (authLoginStatus != updateLoginStatus) {
      authLoginStatus = updateLoginStatus;
    }
    log(authLoginStatus.toString());
    // debugPrint(authLoginStatus.toString());
  }
}
