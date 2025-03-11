import 'package:flutter/material.dart';

@immutable
class MasterSubservicesParams {
  final int? serviceId;
  final int? genderId;

  const MasterSubservicesParams({
    this.serviceId,
    this.genderId,
  });

  Map<String, dynamic> toJson() {
    return {
      if (serviceId != null) "service_id": serviceId,
      if (genderId != null) "gender_id": genderId,
    };
  }

  MasterSubservicesParams copyWith({
    int? serviceId,
    int? genderId,
  }) {
    return MasterSubservicesParams(
      serviceId: serviceId ?? this.serviceId,
      genderId: genderId ?? this.genderId,
    );
  }
}
