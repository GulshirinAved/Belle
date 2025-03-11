// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../utils/utils.dart';
import '../../../shared/shared.dart';
import '../../master.dart';

part 'master_add_vacation_state_controller.g.dart';

class MasterAddVacationController extends BaseController<void> {
  final _repository = GetIt.instance<MasterAddVacationRepository>();

  Future<void> sendData(MasterHolidayToSendDto data) async {
    await postData(() => _repository.postData(data).then((value) {
          handleSuccess(value.message);
          return value;
        }));
  }
}

class MasterAddVacationStateController = _MasterAddVacationStateControllerBase
    with _$MasterAddVacationStateController;

abstract class _MasterAddVacationStateControllerBase
    with Store, HandlingErrorMixin {
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
