import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/booking/data/dto/calendar_response_model.dart';
import 'package:belle/src/features/client/booking/data/dto/chosen_service_to_send_dto.dart';
import 'package:dio/dio.dart';

abstract class BookingRepository {
  Future<ObjectResponse<CalendarResponseModel>> postChosenServicesData(
      ChosenServicesToSendDto? data);
  factory BookingRepository(Dio client) => _BookingRepositoryImpl(client);
}

class _BookingRepositoryImpl implements BookingRepository {
  final Dio _client;

  const _BookingRepositoryImpl(this._client);

  @override
  Future<ObjectResponse<CalendarResponseModel>> postChosenServicesData(
      ChosenServicesToSendDto? data) async {
    if(data == null) {
      throw 'Data is null';
    }
    final response =
        await _client.postData<ObjectResponse<CalendarResponseModel>>(
      ApiPathHelper.chosenServices(ChosenServicesPath.base),
      data: data.toJson(),
      converter: (json) =>
          ObjectResponse.fromJson(json, CalendarResponseModel.fromJson),
    );
    return response;
  }
}
