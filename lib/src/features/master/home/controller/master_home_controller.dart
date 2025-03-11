// ignore_for_file: library_private_types_in_public_api
import 'package:belle/src/features/master/api_models/api_models.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../utils/utils.dart';

import '../../master.dart';

part 'master_home_controller.g.dart';

class MasterBookingsController
    extends BaseController<MasterCalendarBookingDto> {
  final MasterHomeRepository _repository;

  MasterBookingsParams params = MasterBookingsParams(
    year: DateTime.now().year,
    month: DateTime.now().month,
    day: DateTime.now().day,
  );

  MasterBookingsController(this._repository);

  void changeDate(DateTime date) {
    final newParams = params.copyWith(
      year: date.year,
      month: date.month,
      day: date.day,
    );
    if (params == newParams) {
      return;
    }
    params = params.copyWith(
      year: date.year,
      month: date.month,
      day: date.day,
    );
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    await loadInitialListData(
      ({int? size, int? number}) => _repository.fetchBookings(params: params),
    );
  }
}

class MasterFreeSlotsController
    extends BaseController<MasterCalendarFreeSlotsDto> {
  final MasterHomeRepository _repository;

  MasterFreeSlotsController(this._repository);

  Future<void> fetchFreeSlots() async {
    await fetchData(
      () => _repository.fetchFreeSlots(),
    );
  }
}

class MasterHomeController with Store {
  final _repository = GetIt.instance<MasterHomeRepository>();
  late final MasterBookingsController bookingsController;
  late final MasterFreeSlotsController freeSlotsController;

  MasterHomeController() {
    bookingsController = MasterBookingsController(_repository);
    freeSlotsController = MasterFreeSlotsController(_repository);
  }

  @computed
  bool get isError => [bookingsController, freeSlotsController]
      .any((controller) => (controller as BaseController).stateManager.isError);

  Future<void> loadAllData() async {
    await Future.wait([
      bookingsController.fetchBookings(),
      freeSlotsController.fetchFreeSlots(),
    ]);
  }

  void setContext(BuildContext context) {
    bookingsController.setContext(context);
    freeSlotsController.setContext(context);
  }
}

class MasterHomeStateController = _MasterHomeStateControllerBase
    with _$MasterHomeStateController;

abstract class _MasterHomeStateControllerBase with Store, HandlingErrorMixin {
  @observable
  DateTime selectedDate = DateTime.now();

  @action
  void changeSelectedDate(DateTime date) {
    final formattedNewDate = DateTime(date.year, date.month, date.day);
    final formattedSelectedDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    if (formattedSelectedDate == formattedNewDate) {
      return;
    }
    selectedDate = formattedSelectedDate;
  }
}
