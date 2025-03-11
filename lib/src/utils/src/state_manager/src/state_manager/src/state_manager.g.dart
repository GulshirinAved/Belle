// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StateManager on _StateManager, Store {
  late final _$isLoadingAtom =
      Atom(name: '_StateManager.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isErrorAtom =
      Atom(name: '_StateManager.isError', context: context);

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_StateManager.errorMessage', context: context);

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

  late final _$isSuccessAtom =
      Atom(name: '_StateManager.isSuccess', context: context);

  @override
  bool get isSuccess {
    _$isSuccessAtom.reportRead();
    return super.isSuccess;
  }

  @override
  set isSuccess(bool value) {
    _$isSuccessAtom.reportWrite(value, super.isSuccess, () {
      super.isSuccess = value;
    });
  }

  late final _$isPaginationLoadingAtom =
      Atom(name: '_StateManager.isPaginationLoading', context: context);

  @override
  bool get isPaginationLoading {
    _$isPaginationLoadingAtom.reportRead();
    return super.isPaginationLoading;
  }

  @override
  set isPaginationLoading(bool value) {
    _$isPaginationLoadingAtom.reportWrite(value, super.isPaginationLoading, () {
      super.isPaginationLoading = value;
    });
  }

  late final _$hasMoreAtom =
      Atom(name: '_StateManager.hasMore', context: context);

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: '_StateManager.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$executeAsyncAction =
      AsyncAction('_StateManager.execute', context: context);

  @override
  Future<T?> execute<T>(Future<T?> Function() action,
      {required void Function(String) onError,
      required void Function() onSuccess}) {
    return _$executeAsyncAction.run(
        () => super.execute<T>(action, onError: onError, onSuccess: onSuccess));
  }

  late final _$executePaginationAsyncAction =
      AsyncAction('_StateManager.executePagination', context: context);

  @override
  Future<void> executePagination(Future<void> Function(int) action,
      {required void Function(String) onError}) {
    return _$executePaginationAsyncAction
        .run(() => super.executePagination(action, onError: onError));
  }

  late final _$_StateManagerActionController =
      ActionController(name: '_StateManager', context: context);

  @override
  void resetPagination() {
    final _$actionInfo = _$_StateManagerActionController.startAction(
        name: '_StateManager.resetPagination');
    try {
      return super.resetPagination();
    } finally {
      _$_StateManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_StateManagerActionController.startAction(
        name: '_StateManager.reset');
    try {
      return super.reset();
    } finally {
      _$_StateManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isError: ${isError},
errorMessage: ${errorMessage},
isSuccess: ${isSuccess},
isPaginationLoading: ${isPaginationLoading},
hasMore: ${hasMore},
currentPage: ${currentPage}
    ''';
  }
}
