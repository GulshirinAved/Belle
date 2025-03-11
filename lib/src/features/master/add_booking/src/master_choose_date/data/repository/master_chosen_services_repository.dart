import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/booking/data/dto/calendar_response_model.dart';
import 'package:belle/src/features/client/booking/data/dto/chosen_service_to_send_dto.dart';
import 'package:belle/src/features/master/master.dart';
import 'package:dio/dio.dart';

abstract class MasterChosenServicesRepository {
  Future<ObjectResponse<CalendarResponseModel>> postChosenServicesData(
      ChosenMasterServicesToSendDto? data);
  factory MasterChosenServicesRepository(Dio client) =>
      _MasterChosenServicesRepositoryImpl(client);
}

class _MasterChosenServicesRepositoryImpl
    implements MasterChosenServicesRepository {
  final Dio _client;

  const _MasterChosenServicesRepositoryImpl(this._client);

  @override
  Future<ObjectResponse<CalendarResponseModel>> postChosenServicesData(
      ChosenMasterServicesToSendDto? data) async {
    if (data == null) {
      throw 'Data is null';
    }
    final response =
        await _client.postData<ObjectResponse<CalendarResponseModel>>(
      MasterApiPathHelper.availableDates(MasterAvailableDates.base),
      data: data.toJson(),
      requiresAuthToken: true,
      converter: (json) =>
          ObjectResponse.fromJson(json, CalendarResponseModel.fromJson),
    );
    return response;
  }
}
