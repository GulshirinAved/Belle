import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

import '../../../client/client.dart';
import '../../master.dart';

class MasterNotificationsController
    extends BaseController<MasterNotificationBookingDto> {
  final _repository = GetIt.instance<MasterNotificationsRepository>();

  Future<void> fetchNotificationsBookings() async {
    await loadInitialListData(
      ({int? size, int? number}) => _repository.fetchNotificationBookings(
        params: PaginationParams(size: size, number: number),
      ),
    );
  }

  Future<void> fetchMoreNotificationsBookings() async {
    await loadMoreListData(
      ({int? size, int? number}) => _repository.fetchNotificationBookings(
        params: PaginationParams(size: size, number: number),
      ),
    );
  }
}
