import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:mobx/mobx.dart';

part 'client_favorites_controller.g.dart';

class ClientFavoritesController extends BaseController<ClientMasterDto> {
  final _repository = GetIt.instance<ClientFavoritesRepository>();
  final servicesController = GetIt.instance<ServicesController>();
  final authStatusController = GetIt.instance<AuthStatusController>();

  ReactionDisposer? _disposer;
  ReactionDisposer? _accountDisposer;

  void init() {
    _accountDisposer = reaction(
      (_) => authStatusController.authLoginStatus,
      (authStatus) {
        if (authStatus != AuthLoginStatus.loggedIn) {
          clearData();
          _disposer?.call();
        } else {
          _disposer = reaction(
            (_) => servicesController.stateManager.isSuccess,
            (isSuccess) {
              if (isSuccess) fetchFavorites();
            },
            fireImmediately: servicesController.stateManager.isSuccess,
          );
        }
      },
      fireImmediately: true,
    );
  }

  void dispose() {
    _disposer?.call();
    _accountDisposer?.call();
  }

  Future<void> fetchFavorites() async {
    await loadInitialListData(({size, number}) =>
        _repository.fetchFavorites(size: size, number: number));
  }

  Future<void> deleteAllFavorites() async {
    await postData<void>(() {
      return _repository.deleteAll();
    });
    clearData();
  }

  void deleteLocalData() {
    clearData();
  }
}

class ClientFavoritesStateController = _ClientFavoritesStateControllerBase
    with _$ClientFavoritesStateController;

abstract class _ClientFavoritesStateControllerBase
    with Store, HandlingErrorMixin {
  final _clientFavoritesController =
      GetIt.instance<ClientFavoritesController>();
  final _repository = GetIt.instance<ClientFavoritesRepository>();
  final _authStatusController = GetIt.instance<AuthStatusController>();
  final _servicesController = GetIt.instance<ServicesController>();

  BuildContext? buildContext;
  ReactionDisposer? _disposer;
  ReactionDisposer? _accountDisposer;

  void init() {
    _accountDisposer = reaction(
      (_) => _authStatusController.authLoginStatus,
      (authStatus) {
        if (authStatus != AuthLoginStatus.loggedIn) {
          clearData();
          _disposer?.call();
        } else {
          _disposer = reaction(
            (_) => _clientFavoritesController.stateManager.isSuccess,
            (isSuccess) {
              if (isSuccess) {
                initFavorites(_clientFavoritesController.items);
                initCurrentServiceId();
              }
            },
            fireImmediately: _clientFavoritesController.stateManager.isSuccess,
          );
        }
      },
      fireImmediately: true,
    );
  }


  @action
  void clearData() {
    _favorites.clear();
  }

  void dispose() {
    _disposer?.call();
    _accountDisposer?.call();
  }

  @observable
  bool syncLoading = false;

  @observable
  ObservableMap<num, ClientMasterDto> _favorites =
      ObservableMap<num, ClientMasterDto>();

  @computed
  List<ClientMasterDto> get favorites => _favorites.values.toList();

  @observable
  int? _currentServiceId;

  @computed
  List<ClientMasterDto> get sortedFavorites => _favorites.values
      .where((master) => master.profileId == _currentServiceId)
      .toList();

  @action
  void changeCurrentServiceId(int? id) {
    if (id == null || _currentServiceId == id) {
      return;
    }
    // print(id);
    _currentServiceId = id;
  }

  @action
  void initCurrentServiceId() {
    if (_servicesController.items.isEmpty) {
      return;
    }
    _currentServiceId = _servicesController.items.first.id;
  }

  @action
  bool isFavorite(num? masterId) {
    return _favorites.containsKey(masterId);
  }

  @action
  void initFavorites(List<ClientMasterDto>? items) {
    _favorites.clear();
    for (final item in items ?? <ClientMasterDto>[]) {
      _favorites.addAll({item.masterId ?? 0: item});
    }
  }

  void setBuildContext(BuildContext context) {
    setContext(context);
    buildContext = context;
  }

  @action
  Future<void> _addToWishlist(ClientMasterDto master) async {
    _favorites.addAll({master.masterId ?? 0: master});
    syncLoading = true;
    try {
      await _repository.addOrRemoveFavorite(master.masterId?.toInt());
      handleSuccess('Successfully added to favorites');
    } catch (e) {
      _favorites.remove(master.masterId);
      handleError('Error adding to favorites');
    } finally {
      syncLoading = false;
    }
  }

  @action
  Future<void> _removeFromWishlist(ClientMasterDto master) async {
    _favorites.remove(master.masterId);

    syncLoading = true;
    try {
      await _repository.addOrRemoveFavorite(master.masterId?.toInt());
      handleSuccess('Successfully removed from favorites');
    } catch (e) {
      _favorites.addAll({master.masterId ?? 0: master});
      handleError('Error removing from favorites');
    } finally {
      syncLoading = false;
    }
  }

  Future<void> handleOnLikeTap(ClientMasterDto? master) async {
    if (master == null) {
      return;
    }
    if (syncLoading || _clientFavoritesController.stateManager.isLoading) {
      ShowSnackHelper.showSnack(
          buildContext!, SnackStatus.warning, 'Wishlist is syncing');
      return;
    }
    if (_authStatusController.authLoginStatus != AuthLoginStatus.loggedIn) {
      ShowSnackHelper.showSnack(buildContext!, SnackStatus.warning,
          buildContext!.loc.register_to_see_favorites);
      return;
    }
    if (_favorites.containsKey(master.masterId)) {
      await _removeFromWishlist(master);
    } else {
      await _addToWishlist(master);
    }
  }
}
