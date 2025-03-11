import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:dio/dio.dart';

abstract class ClientBookingNotificationsRepository {
  Future<ListResponse<NotificationBookingInfoDto>> getBookingNotification(
      {int? size, int? number});
  factory ClientBookingNotificationsRepository(Dio client) =>
      _ClientBookingNotificationsRepositoryImpl(client);
}

class _ClientBookingNotificationsRepositoryImpl
    implements ClientBookingNotificationsRepository {
  final Dio _client;

  _ClientBookingNotificationsRepositoryImpl(this._client);
  @override
  Future<ListResponse<NotificationBookingInfoDto>> getBookingNotification(
      {int? size, int? number}) async {
    final response = await _client.getData(
        ApiPathHelper.clientNotificationBooking(ClientNotifyBookingPath.base),
        converter: (json) =>
            ListResponse.fromJson(json, NotificationBookingInfoDto.fromJson),
        requiresAuthToken: true);
    return response;
  }
}
