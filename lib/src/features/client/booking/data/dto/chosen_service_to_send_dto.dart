import 'package:flutter/foundation.dart';

@immutable
class ChosenServicesToSendDto {
  final int? masterId;
  final List<int?> subServicesIds;
  final int? month;
  final int? year;

  const ChosenServicesToSendDto({
    required this.masterId,
    required this.subServicesIds,
    this.month,
    this.year,
  });

  Map<String, dynamic> toJson() {
    return {
      "master_id": masterId,
      "subservice_ids": subServicesIds,
      if (month != null) "month": month,
      if (year != null) "year": year,
    };
  }

  ChosenServicesToSendDto copyWith({
    int? masterId,
    List<int?>? subServicesIds,
    int? month,
    int? year,
  }) {
    return ChosenServicesToSendDto(
      masterId: masterId ?? this.masterId,
      subServicesIds: subServicesIds ?? this.subServicesIds,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }
}