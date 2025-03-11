import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

import '../../../../master.dart';

class MasterCreateBookingController extends BaseController<void> {
  final _repository = GetIt.instance<MasterMakeBookingRepository>();

  Future<void> makeBooking(MasterCreateBookingDto? bookingDto) async {
    if (bookingDto == null) {
      return;
    }
    await postData(
      () => _repository.makeBooking(bookingDto),
    );
  }
}
