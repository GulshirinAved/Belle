import 'package:belle/src/core/src/local/local.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:belle/src/utils/utils.dart';

import '../../client.dart';

class ClientExploreController extends BaseController<ClientMasterDto> {
  final repository = GetIt.instance<ClientExploreRepository>();

  final servicesController = GetIt.instance<ServicesController>();

  ClientMastersParams? _params;
  ClientMastersSortParams? _sortParams;

  ClientMastersSortParams? get sortParams => _sortParams;

  ReactionDisposer? _disposer;

  void init() {
    _disposer = reaction(
      (_) => servicesController.stateManager.isSuccess == true,
      (_) async {
        _setupParams();
        await fetchMasters();
      },
      fireImmediately: servicesController.stateManager.isSuccess,
    );
  }

  void _setupParams() {
    final masterTypeController = GetIt.instance<MasterTypeController>();

    _params = ClientMastersParams(
      masterTypeId: masterTypeController.currentMasterType.id,
      profileId: servicesController.items.first.id,
    );
  }

  void updateParams(ClientMastersSortParams? sortParams) {
    _sortParams = sortParams;
    _params = _params?.copyWith(
      sortParams: sortParams,
    );
  }

  Future<void> fetchMasters([int? serviceId]) async {
    if (_params == null) {
      return;
    }
    if (serviceId != null) {
      _params = _params!.copyWith(
        profileId: serviceId,
      );
    }
    await loadInitialListData(
      ({size, number}) => repository.fetchMasters(
        params: _params!,
      ),
    );
  }

  Future<void> fetchMastersPagination() async {
    if (_params == null) {
      return;
    }
    await loadMoreListData(
      ({size, number}) => repository.fetchMasters(
        params: _params!.copyWith(
          size: size,
          number: number,
        ),
      ),
    );
  }

  void dispose() {
    _disposer?.call();
  }
}

class ClientExploreSearchController extends BaseController<ClientMasterDto> {
  final keyValue = KeyValueStorageService();
  final searchKey = 'search';
  final repository = GetIt.instance<ClientExploreRepository>();

  ObservableList<String> previousSearches = ObservableList();

  @action
  void fetchPreviousSearches() {
    previousSearches =
        ObservableList.of(keyValue.getValue<List<String>>(searchKey) ?? []);
  }

  @action
  Future<void> removePreviousSearchAt(int index) async {
    previousSearches.removeAt(index);
    await keyValue.setValue<List<String>>(searchKey, previousSearches.toList());
  }

  Future<void> fetchMasters([String? query]) async {
    if (query != null && query.isNotEmpty) {
      if (!previousSearches.contains(query)) {
        previousSearches.add(query);
      }
    }

    await keyValue.setValue<List<String>>(
      searchKey,
      previousSearches.toList(),
    );
    final masterTypeController = GetIt.instance<MasterTypeController>();

    await loadInitialListData(
      ({size, number}) => repository.fetchMasters(
        params: ClientMastersParams(
          query: query,
          masterTypeId: masterTypeController.currentMasterType.id,
        ),
      ),
    );
  }

  Future<void> fetchMastersPagination([String? query]) async {
    final masterTypeController = GetIt.instance<MasterTypeController>();

    await loadMoreListData(
      ({size, number}) => repository.fetchMasters(
        params: ClientMastersParams(
          size: size,
          number: number,
          query: query,
          masterTypeId: masterTypeController.currentMasterType.id,
        ),
      ),
    );
  }
}
