import 'package:belle/src/features/master/master.dart';
import 'package:flutter/foundation.dart';

@immutable
class ChosenMasterServicesToSendDto {
  final List<int?> subServicesIds;
  final int? month;
  final int? year;
  final String? time;
  final String? clientName;
  final String? clientPhone;

  // add this only for UI
  final List<MasterOwnSubserviceDto>? subservices;

  const ChosenMasterServicesToSendDto({
    required this.subServicesIds,
    this.month,
    this.year,
    this.time,
    this.clientName,
    this.clientPhone,
    this.subservices,
  });

  Map<String, dynamic> toJson() {
    return {
      "subservice_ids": subServicesIds,
      if (clientPhone != null) "client_phone": clientPhone,
      if (clientName != null) "client_person_fn": clientName,
      if (month != null) "month": month,
      if (year != null) "year": year,
      if (time != null) "time": time,
    };
  }

  ChosenMasterServicesToSendDto copyWith({
    List<int?>? subServicesIds,
    int? month,
    int? year,
    String? time,
    String? clientName,
    String? clientPhone,
    List<MasterOwnSubserviceDto>? subservices,
  }) {
    return ChosenMasterServicesToSendDto(
      subServicesIds: subServicesIds ?? this.subServicesIds,
      month: month ?? this.month,
      year: year ?? this.year,
      time: time ?? this.time,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      subservices: this.subservices,
    );
  }
}

@immutable
class MasterCreateBookingDto {
  final List<int?> subServicesIds;
  final String? date;
  final String? time;
  final String? clientName;
  final String? clientPhone;

  // add this only for UI
  final List<MasterOwnSubserviceDto>? subservices;

  const MasterCreateBookingDto({
    required this.subServicesIds,
    this.date,
    this.time,
    this.clientName,
    this.clientPhone,
    this.subservices,
  });

  Map<String, dynamic> toJson() {
    return {
      "subservice_ids": subServicesIds,
      if (clientPhone != null) "client_phone": clientPhone,
      if (clientName != null) "client_person_fn": clientName,
      if (date != null) "date": date,
      if (time != null) "time": time,
      'booking_location_id': 1,
    };
  }

  MasterCreateBookingDto copyWith({
    List<int?>? subServicesIds,
    int? month,
    int? year,
    String? time,
    String? clientName,
    String? clientPhone,
    List<MasterOwnSubserviceDto>? subservices,
  }) {
    return MasterCreateBookingDto(
      subServicesIds: subServicesIds ?? this.subServicesIds,
      date: date,
      time: time ?? this.time,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      subservices: subservices ?? this.subservices,
    );
  }
}
