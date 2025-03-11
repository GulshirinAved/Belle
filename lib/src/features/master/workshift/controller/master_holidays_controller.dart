import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

import '../../master.dart';

class MasterHolidaysController extends BaseController<MasterHolidayDto> {
  final _repository = GetIt.instance<MasterHolidaysRepository>();

  Future<void> fetchHolidays() async {
    await loadInitialListData(
      ({int? size, int? number}) => _repository.fetchHolidays(),
    );
  }
}
