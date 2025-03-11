// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_favorites_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClientFavoritesStateController
    on _ClientFavoritesStateControllerBase, Store {
  Computed<List<ClientMasterDto>>? _$favoritesComputed;

  @override
  List<ClientMasterDto> get favorites => (_$favoritesComputed ??=
          Computed<List<ClientMasterDto>>(() => super.favorites,
              name: '_ClientFavoritesStateControllerBase.favorites'))
      .value;
  Computed<List<ClientMasterDto>>? _$sortedFavoritesComputed;

  @override
  List<ClientMasterDto> get sortedFavorites => (_$sortedFavoritesComputed ??=
          Computed<List<ClientMasterDto>>(() => super.sortedFavorites,
              name: '_ClientFavoritesStateControllerBase.sortedFavorites'))
      .value;

  late final _$syncLoadingAtom = Atom(
      name: '_ClientFavoritesStateControllerBase.syncLoading',
      context: context);

  @override
  bool get syncLoading {
    _$syncLoadingAtom.reportRead();
    return super.syncLoading;
  }

  @override
  set syncLoading(bool value) {
    _$syncLoadingAtom.reportWrite(value, super.syncLoading, () {
      super.syncLoading = value;
    });
  }

  late final _$_favoritesAtom = Atom(
      name: '_ClientFavoritesStateControllerBase._favorites', context: context);

  @override
  ObservableMap<num, ClientMasterDto> get _favorites {
    _$_favoritesAtom.reportRead();
    return super._favorites;
  }

  @override
  set _favorites(ObservableMap<num, ClientMasterDto> value) {
    _$_favoritesAtom.reportWrite(value, super._favorites, () {
      super._favorites = value;
    });
  }

  late final _$_currentServiceIdAtom = Atom(
      name: '_ClientFavoritesStateControllerBase._currentServiceId',
      context: context);

  @override
  int? get _currentServiceId {
    _$_currentServiceIdAtom.reportRead();
    return super._currentServiceId;
  }

  @override
  set _currentServiceId(int? value) {
    _$_currentServiceIdAtom.reportWrite(value, super._currentServiceId, () {
      super._currentServiceId = value;
    });
  }

  late final _$_addToWishlistAsyncAction = AsyncAction(
      '_ClientFavoritesStateControllerBase._addToWishlist',
      context: context);

  @override
  Future<void> _addToWishlist(ClientMasterDto master) {
    return _$_addToWishlistAsyncAction.run(() => super._addToWishlist(master));
  }

  late final _$_removeFromWishlistAsyncAction = AsyncAction(
      '_ClientFavoritesStateControllerBase._removeFromWishlist',
      context: context);

  @override
  Future<void> _removeFromWishlist(ClientMasterDto master) {
    return _$_removeFromWishlistAsyncAction
        .run(() => super._removeFromWishlist(master));
  }

  late final _$_ClientFavoritesStateControllerBaseActionController =
      ActionController(
          name: '_ClientFavoritesStateControllerBase', context: context);

  @override
  void clearData() {
    final _$actionInfo = _$_ClientFavoritesStateControllerBaseActionController
        .startAction(name: '_ClientFavoritesStateControllerBase.clearData');
    try {
      return super.clearData();
    } finally {
      _$_ClientFavoritesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentServiceId(int? id) {
    final _$actionInfo =
        _$_ClientFavoritesStateControllerBaseActionController.startAction(
            name: '_ClientFavoritesStateControllerBase.changeCurrentServiceId');
    try {
      return super.changeCurrentServiceId(id);
    } finally {
      _$_ClientFavoritesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void initCurrentServiceId() {
    final _$actionInfo =
        _$_ClientFavoritesStateControllerBaseActionController.startAction(
            name: '_ClientFavoritesStateControllerBase.initCurrentServiceId');
    try {
      return super.initCurrentServiceId();
    } finally {
      _$_ClientFavoritesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  bool isFavorite(num? masterId) {
    final _$actionInfo = _$_ClientFavoritesStateControllerBaseActionController
        .startAction(name: '_ClientFavoritesStateControllerBase.isFavorite');
    try {
      return super.isFavorite(masterId);
    } finally {
      _$_ClientFavoritesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void initFavorites(List<ClientMasterDto>? items) {
    final _$actionInfo = _$_ClientFavoritesStateControllerBaseActionController
        .startAction(name: '_ClientFavoritesStateControllerBase.initFavorites');
    try {
      return super.initFavorites(items);
    } finally {
      _$_ClientFavoritesStateControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
syncLoading: ${syncLoading},
favorites: ${favorites},
sortedFavorites: ${sortedFavorites}
    ''';
  }
}
