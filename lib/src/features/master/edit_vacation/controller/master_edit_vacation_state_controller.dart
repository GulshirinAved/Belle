// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../utils/utils.dart';
import '../../../shared/shared.dart';
import '../../master.dart';

part 'master_edit_vacation_state_controller.g.dart';

class MasterEditVacationController extends BaseController<void> {
  final _repository = GetIt.instance<MasterEditVacationRepository>();

  Future<void> sendData(MasterHolidayToSendDto data) async {
    await postData(
      () => _repository.postData(data).then(
        (value) {
          handleSuccess(value.message);
          return value;
        },
      ),
    );
  }

  Future<void> deleteVacation(int? id) async {
    await postData(
      () => _repository.deleteData(id ?? 0).then(
        (value) {
          handleSuccess(value.message);
          return value;
        },
      ),
    );
  }
}

class MasterEditVacationStateController = _MasterEditVacationStateControllerBase
    with _$MasterEditVacationStateController;

abstract class _MasterEditVacationStateControllerBase
    with Store, HandlingErrorMixin {
  void initHolidayDto(MasterHolidayDto dto) {
    if (dto.dateStart != null) {
      rangeStartDate = DateTime.tryParse(dto.dateStart ?? '');
    }
    if (dto.dateEnd != null) {
      rangeEndDate = DateTime.tryParse(dto.dateEnd ?? '');
    }
    if (dto.reason != null) {
      selectedReason = HolidayDto(
        id: dto.reasonId,
        name: dto.reason,
      );
    }
  }

  @observable
  HolidayDto? selectedReason;

  @observable
  DateTime? rangeStartDate = DateTime.now();

  @observable
  DateTime? rangeEndDate = DateTime.now().add(const Duration(days: 1));

  @action
  void changeRangeDates(DateTime start, DateTime end) {
    rangeStartDate = start;
    rangeEndDate = end;
  }

  @action
  void changeSelectedReason(HolidayDto? data) {
    if (selectedReason == data) {
      return;
    }
    selectedReason = data;
  }

  MasterHolidayToSendDto generateData(BuildContext context) {
    return MasterHolidayToSendDto(
      reasonId: selectedReason?.id,
      reason: selectedReason?.name,
      dateStart: rangeStartDate,
      dateEnd: rangeEndDate,
    );
  }
}
