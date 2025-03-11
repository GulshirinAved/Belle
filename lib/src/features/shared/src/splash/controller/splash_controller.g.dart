// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SplashController on _SplashControllerBase, Store {
  late final _$isAuthStatusReadyAtom =
      Atom(name: '_SplashControllerBase.isAuthStatusReady', context: context);

  @override
  bool get isAuthStatusReady {
    _$isAuthStatusReadyAtom.reportRead();
    return super.isAuthStatusReady;
  }

  @override
  set isAuthStatusReady(bool value) {
    _$isAuthStatusReadyAtom.reportWrite(value, super.isAuthStatusReady, () {
      super.isAuthStatusReady = value;
    });
  }

  late final _$isReferencesReadyAtom =
      Atom(name: '_SplashControllerBase.isReferencesReady', context: context);

  @override
  bool get isReferencesReady {
    _$isReferencesReadyAtom.reportRead();
    return super.isReferencesReady;
  }

  @override
  set isReferencesReady(bool value) {
    _$isReferencesReadyAtom.reportWrite(value, super.isReferencesReady, () {
      super.isReferencesReady = value;
    });
  }

  late final _$initializeAppAsyncAction =
      AsyncAction('_SplashControllerBase.initializeApp', context: context);

  @override
  Future<void> initializeApp(
      VoidCallback navigateToMaster, VoidCallback navigateToClient) {
    return _$initializeAppAsyncAction
        .run(() => super.initializeApp(navigateToMaster, navigateToClient));
  }

  @override
  String toString() {
    return '''
isAuthStatusReady: ${isAuthStatusReady},
isReferencesReady: ${isReferencesReady}
    ''';
  }
}
