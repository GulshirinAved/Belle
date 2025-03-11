import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:dio/dio.dart';

abstract class MasterNotificationsRepository {
  Future<ListResponse<MasterNotificationBookingDto>> fetchNotificationBookings(
      {PaginationParams? params});

  factory MasterNotificationsRepository(Dio client) =>
      _MasterNotificationsRepositoryImpl(client);
}

class _MasterNotificationsRepositoryImpl
    implements MasterNotificationsRepository {
  final Dio _client;

  const _MasterNotificationsRepositoryImpl(this._client);

  @override
  Future<ListResponse<MasterNotificationBookingDto>> fetchNotificationBookings(
      {PaginationParams? params}) async {
    final response = await _client.getData(
      MasterApiPathHelper.notifications(MasterNotificationsPath.bookings),
      converter: (json) =>
          ListResponse.fromJson(json, MasterNotificationBookingDto.fromJson),
      requiresAuthToken: true,
      queryParameters: params?.toJson(),
    );
    return response;
  }
}
