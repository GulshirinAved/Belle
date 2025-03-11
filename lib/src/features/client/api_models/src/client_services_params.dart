import 'package:flutter/foundation.dart';

import 'client_masters_params.dart';

@immutable
class ClientServicesParams {
  final int? size;
  final int? number;
  final int? masterTypeId;
  final int? serviceId;
  final int? subServiceId;

  const ClientServicesParams({
    this.size,
    this.number,
    required this.masterTypeId,
    this.serviceId,
    this.subServiceId,
  });

  Map<String, dynamic> toJson() {
    return {
      genderId: masterTypeId,
      if (number != null) "page": number,
      if (size != null) "per_page": size,
      if (serviceId != null) "service_id": serviceId,
      if (subServiceId != null) "subservice_id": subServiceId,
    };
  }

  ClientServicesParams copyWith({
    int? size,
    int? number,
    int? masterTypeId,
    int? serviceId,
    int? subServiceId,
  }) {
    return ClientServicesParams(
      size: size ?? this.size,
      number: number ?? this.number,
      masterTypeId: masterTypeId ?? this.masterTypeId,
      serviceId: serviceId ?? this.serviceId,
      subServiceId: subServiceId ?? this.subServiceId,
    );
  }

}
