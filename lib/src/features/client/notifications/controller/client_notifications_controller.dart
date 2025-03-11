import 'package:get_it/get_it.dart';
import 'package:belle/src/utils/utils.dart';

import '../../client.dart';

class ClientNotificationsController
    extends BaseController<ClientNotificationDto> {
  final _repository = GetIt.instance<ClientNotificationsRepository>();

  Future<void> getNotifications() async {
    await loadInitialListData(
      ({int? size, int? number}) =>
          _repository.getNotifications(size: size, number: number),
    );
  }

  Future<void> getMoreNotifications() async {
    await loadInitialListData(
      ({int? size, int? number}) =>
          _repository.getNotifications(size: size, number: number),
    );
  }
}
