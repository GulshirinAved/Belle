import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../client.dart';

abstract class ClientNotificationsRepository {
  Future<ListResponse<ClientNotificationDto>> getNotifications(
      {int? size, int? number});

  factory ClientNotificationsRepository(Dio client) =>
      _ClientNotificationsRepositoryImpl(client);
}

class _ClientNotificationsRepositoryImpl
    implements ClientNotificationsRepository {
  final Dio _client;

  const _ClientNotificationsRepositoryImpl(this._client);

  @override
  Future<ListResponse<ClientNotificationDto>> getNotifications(
      {int? size, int? number}) async {
    final response = await _client.getData(
      ApiPathHelper.clientNotificationBooking(ClientNotifyBookingPath.base),
      converter: (json) => ListResponse.fromJson(
        json,
        ClientNotificationDto.fromJson,
      ),
      requiresAuthToken: true,
    );
    return response;
  }
}
