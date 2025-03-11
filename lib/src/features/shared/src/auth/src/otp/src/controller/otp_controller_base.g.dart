// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_controller_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OtpController<TRequestDto, TResendDto, TResult>
    on _OtpController<TRequestDto, TResendDto, TResult>, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_OtpController.isLoading'))
          .value;
  Computed<bool>? _$isErrorComputed;

  @override
  bool get isError => (_$isErrorComputed ??=
          Computed<bool>(() => super.isError, name: '_OtpController.isError'))
      .value;

  late final _$_responseAtom =
      Atom(name: '_OtpController._response', context: context);

  @override
  ObservableFuture<ObjectResponse<TResult>?> get _response {
    _$_responseAtom.reportRead();
    return super._response;
  }

  @override
  set _response(ObservableFuture<ObjectResponse<TResult>?> value) {
    _$_responseAtom.reportWrite(value, super._response, () {
      super._response = value;
    });
  }

  late final _$_resendResponseAtom =
      Atom(name: '_OtpController._resendResponse', context: context);

  @override
  ObservableFuture<ObjectResponse<dynamic>?> get _resendResponse {
    _$_resendResponseAtom.reportRead();
    return super._resendResponse;
  }

  @override
  set _resendResponse(ObservableFuture<ObjectResponse<dynamic>?> value) {
    _$_resendResponseAtom.reportWrite(value, super._resendResponse, () {
      super._resendResponse = value;
    });
  }

  late final _$_firebaseResponseAtom =
      Atom(name: '_OtpController._firebaseResponse', context: context);

  @override
  ObservableFuture<void> get _firebaseResponse {
    _$_firebaseResponseAtom.reportRead();
    return super._firebaseResponse;
  }

  @override
  set _firebaseResponse(ObservableFuture<void> value) {
    _$_firebaseResponseAtom.reportWrite(value, super._firebaseResponse, () {
      super._firebaseResponse = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_OtpController.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$makeOtpAsyncAction =
      AsyncAction('_OtpController.makeOtp', context: context);

  @override
  Future<void> makeOtp(String code, void Function() successCallback) {
    return _$makeOtpAsyncAction.run(() => super.makeOtp(code, successCallback));
  }

  late final _$_firebaseSubscriptionAsyncAction =
      AsyncAction('_OtpController._firebaseSubscription', context: context);

  @override
  Future<void> _firebaseSubscription(String accessToken) {
    return _$_firebaseSubscriptionAsyncAction
        .run(() => super._firebaseSubscription(accessToken));
  }

  late final _$resendCodeAsyncAction =
      AsyncAction('_OtpController.resendCode', context: context);

  @override
  Future<void> resendCode() {
    return _$resendCodeAsyncAction.run(() => super.resendCode());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
isLoading: ${isLoading},
isError: ${isError}
    ''';
  }
}
