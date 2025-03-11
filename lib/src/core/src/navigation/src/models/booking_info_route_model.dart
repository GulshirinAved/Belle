import 'package:belle/src/features/master/master.dart';
import 'package:flutter/foundation.dart';

import '../../../../../features/client/client.dart';

@immutable
class BookingInfoRouteModel {
  final ClientMasterInfoDto? masterInfo;
  final ChosenServicesToSendDto? chosenServicesToSendDto;

  const BookingInfoRouteModel({
    required this.masterInfo,
    required this.chosenServicesToSendDto,
  });
}

@immutable
class MasterBookingInfoRouteModel {
  final String? time;
  final List<int>? chosenServicesToSendDto;
  final List<MasterOwnSubserviceDto>? chosenServices;

  const MasterBookingInfoRouteModel({
    this.time,
    this.chosenServicesToSendDto,
    this.chosenServices,
  });
}
