import 'package:belle/src/features/master/master.dart';
import 'package:dio/dio.dart';

import '../../../../../../../core/core.dart';

abstract class MasterMakeBookingRepository {
  Future<ObjectResponse> makeBooking(MasterCreateBookingDto data);

  factory MasterMakeBookingRepository(Dio client) =>
      _MasterMakeBookingRepositoryImpl(client);
}

class _MasterMakeBookingRepositoryImpl implements MasterMakeBookingRepository {
  final Dio _client;

  const _MasterMakeBookingRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> makeBooking(MasterCreateBookingDto data) async {
    final response = await _client.postData(
      ApiPathHelper.createBooking(CreateBookingPath.base),
      data: data.toJson(),
      converter: (_) {
        return const ObjectResponse();
      },
      requiresAuthToken: true,
    );
    return response;
  }
}
