import 'package:belle/src/features/client/notifications/data/repository/client_notification_booking_repository.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:get_it/get_it.dart';

class ClientNotificationBookingController
    extends BaseController<NotificationBookingInfoDto> {
  final _repository = GetIt.instance<ClientBookingNotificationsRepository>();
  Future<void> getBookingNotifications() async {
    try {
      await loadInitialListData(
        ({int? size, int? number}) =>
            _repository.getBookingNotification(size: size, number: number),
      );
    } catch (e, stackTrace) {
      print("Error fetching notifications: $e");
      print(stackTrace);
    }
  }

  Future<void> getMoreBookingNotifications() async {
    await loadInitialListData(({int? size, int? number}) =>
        _repository.getBookingNotification(size: size, number: number));
  }
}
