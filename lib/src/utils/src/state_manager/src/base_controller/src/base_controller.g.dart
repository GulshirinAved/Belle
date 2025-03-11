// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseController<T> on _BaseController<T>, Store {
  Computed<bool>? _$isEmptyComputed;

  @override
  bool get isEmpty => (_$isEmptyComputed ??=
          Computed<bool>(() => super.isEmpty, name: '_BaseController.isEmpty'))
      .value;

  late final _$dataAtom = Atom(name: '_BaseController.data', context: context);

  @override
  T? get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(T? value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$itemsAtom =
      Atom(name: '_BaseController.items', context: context);

  @override
  ObservableList<T> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<T> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$loadInitialListDataAsyncAction =
      AsyncAction('_BaseController.loadInitialListData', context: context);

  @override
  Future<void> loadInitialListData(
      Future<ListResponse<T>> Function({int? number, int? size}) fetch,
      {int size = 10}) {
    return _$loadInitialListDataAsyncAction
        .run(() => super.loadInitialListData(fetch, size: size));
  }

  late final _$loadMoreListDataAsyncAction =
      AsyncAction('_BaseController.loadMoreListData', context: context);

  @override
  Future<void> loadMoreListData(
      Future<ListResponse<T>> Function({int? number, int? size}) fetch,
      {int size = 10}) {
    return _$loadMoreListDataAsyncAction
        .run(() => super.loadMoreListData(fetch, size: size));
  }

  late final _$fetchDataAsyncAction =
      AsyncAction('_BaseController.fetchData', context: context);

  @override
  Future<void> fetchData(Future<ObjectResponse<T>> Function() fetch) {
    return _$fetchDataAsyncAction.run(() => super.fetchData(fetch));
  }

  late final _$postDataAsyncAction =
      AsyncAction('_BaseController.postData', context: context);

  @override
  Future<void> postData<R>(Future<ObjectResponse<R>> Function() post,
      {String? successMessage}) {
    return _$postDataAsyncAction
        .run(() => super.postData<R>(post, successMessage: successMessage));
  }

  late final _$deleteDataAsyncAction =
      AsyncAction('_BaseController.deleteData', context: context);

  @override
  Future<R?> deleteData<R>(Future<ObjectResponse<R>> Function() delete,
      {String? successMessage}) {
    return _$deleteDataAsyncAction
        .run(() => super.deleteData<R>(delete, successMessage: successMessage));
  }

  late final _$updateDataAsyncAction =
      AsyncAction('_BaseController.updateData', context: context);

  @override
  Future<R?> updateData<R>(Future<ObjectResponse<R>> Function() update,
      {String? successMessage}) {
    return _$updateDataAsyncAction
        .run(() => super.updateData<R>(update, successMessage: successMessage));
  }

  late final _$_BaseControllerActionController =
      ActionController(name: '_BaseController', context: context);

  @override
  void clearData() {
    final _$actionInfo = _$_BaseControllerActionController.startAction(
        name: '_BaseController.clearData');
    try {
      return super.clearData();
    } finally {
      _$_BaseControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setData(T newData) {
    final _$actionInfo = _$_BaseControllerActionController.startAction(
        name: '_BaseController.setData');
    try {
      return super.setData(newData);
    } finally {
      _$_BaseControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
data: ${data},
items: ${items},
isEmpty: ${isEmpty}
    ''';
  }
}
