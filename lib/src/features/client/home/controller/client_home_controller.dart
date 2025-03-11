import 'dart:developer';

import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/language/controller/language_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:belle/src/utils/utils.dart';

class ServicesController extends BaseController<ClientServiceDto> {
  final repository = GetIt.instance<ClientHomeRepository>();

  final _langController = GetIt.instance<LanguageController>();
  final _masterTypeController = GetIt.instance<MasterTypeController>();

  ReactionDisposer? _masterTypeDisposer;
  ReactionDisposer? _disposer;

  ClientServicesParams? params;

  void init() {
    log('Services Controller | initializing disposer');
    _setupParams(_masterTypeController.currentMasterType.id);
    _disposer = reaction(
      (_) => _langController.localeCode,
      (_) {
        _setupParams(_masterTypeController.currentMasterType.id);
        fetchServices();
      },
      fireImmediately: true,
    );
    _masterTypeDisposer = reaction(
      (_) => _masterTypeController.currentMasterType,
      (type) {
        _setupParams(type.id);
        fetchServices();
      },
      fireImmediately: true,
    );
  }

  void _setupParams(int? masterTypeId) {
    params = ClientServicesParams(
      masterTypeId: masterTypeId,
    );
  }

  void dispose() {
    _disposer?.call();
    _masterTypeDisposer?.call();
  }

  Future<void> fetchServices([int? masterTypeId]) async {
    if (params == null) {
      return;
    }
    if (masterTypeId != params?.masterTypeId) {
      await loadInitialListData(
        ({size, number}) => repository.fetchServices(
          params: params!.copyWith(
            masterTypeId: masterTypeId,
          ),
        ),
      );
    }
    await loadInitialListData(
      ({size, number}) => repository.fetchServices(
        params: params!,
      ),
    );
  }
}

class NewMastersController extends BaseController<ClientMasterDto> {
  final repository = GetIt.instance<ClientHomeRepository>();

  Future<void> fetchMasters(int typeId) async {
    await loadInitialListData(
      ({size, number}) => repository.fetchNewMasters(
        params: ClientMastersParams(
          size: size,
          number: number,
          masterTypeId: typeId,
          ranking: ClientMasterRanking.newMasters,
        ),
      ),
    );
  }
}

class TopStylistsController extends BaseController<ClientMasterDto> {
  final repository = GetIt.instance<ClientHomeRepository>();

  Future<void> fetchMasters(int typeId) async {
    await loadInitialListData(
      ({size, number}) => repository.fetchTopStylists(
        params: ClientMastersParams(
          // size: size,
          // number: number,
          masterTypeId: typeId,
          ranking: ClientMasterRanking.ranking,
        ),
      ),
    );
  }
}

class ClientHomeController with Store {
  // final servicesController = ServicesController();
  final newMastersController = NewMastersController();
  final topStylistsController = TopStylistsController();

  @computed
  bool get isLoading => [
        // servicesController,
        newMastersController,
        topStylistsController
      ].any((controller) =>
          (controller as BaseController).stateManager.isLoading);

  @computed
  bool get isError => [
        // servicesController,
        newMastersController,
        topStylistsController
      ].any(
          (controller) => (controller as BaseController).stateManager.isError);

  @computed
  bool get isSuccess => [
        // servicesController,
        newMastersController,
        topStylistsController
      ].every((controller) =>
          (controller as BaseController).stateManager.isSuccess);

  @action
  Future<void> loadAllData(int id) async {
    await Future.wait([
      // servicesController.fetchServices(),
      newMastersController.fetchMasters(id),
      topStylistsController.fetchMasters(id),
    ]);
  }

  final _masterTypeController = GetIt.instance<MasterTypeController>();

  ReactionDisposer? _masterTypeDisposer;

  void init() {
    _masterTypeDisposer =
        reaction((_) => _masterTypeController.currentMasterType, (type) {
      loadAllData(type.id);
    });
  }

  void dispose() {
    _masterTypeDisposer?.call();
  }
}
