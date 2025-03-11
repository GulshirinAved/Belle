import 'dart:developer';

import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';

abstract class MasterBookingRepository {
  Future<ObjectResponse> changeBookingStatus(
      {required String id, required int status});

  factory MasterBookingRepository(Dio client) =>
      _MasterBookingRepositoryImpl(client);
}

class _MasterBookingRepositoryImpl implements MasterBookingRepository {
  final Dio _client;

  const _MasterBookingRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> changeBookingStatus(
      {required String id, required int status}) async {
    log("""
{
      'booking_number':$id,
      'status': $status,
    }""");
    final response = await _client.postData(
      MasterApiPathHelper.booking(MasterBookingPath.status),
      data: {
        'booking_number': id,
        'status': status,
      },
      converter: (_) => const ObjectResponse(),
      requiresAuthToken: true,
    );

    return response;
  }
}
