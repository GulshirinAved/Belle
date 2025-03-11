import 'package:belle/src/core/core.dart';

class MasterOwnServicesDto extends Dto
    implements JsonSerializer<MasterOwnServicesDto> {
  final String? name;
  final int? serviceId;
  final List<MasterOwnSubserviceDto>? subservices;

  const MasterOwnServicesDto({
    this.name,
    this.serviceId,
    this.subservices,
  });

  @override
  factory MasterOwnServicesDto.fromJson(Map<String, dynamic> json) {
    return MasterOwnServicesDto(
      name: json['name'] as String?,
      serviceId: json['service_id'] as int?,
      subservices: json['subservices'] != null
          ? List<MasterOwnSubserviceDto>.from(json['subservices']
              .map((x) => MasterOwnSubserviceDto.fromJson(x)))
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (serviceId != null) 'service_id': serviceId,
      if (subservices != null)
        'subservices': subservices!.map((x) => x.toJson()).toList(),
    };
  }

  MasterOwnServicesDto copyWith({
    String? name,
    int? serviceId,
    List<MasterOwnSubserviceDto>? subservices,
  }) {
    return MasterOwnServicesDto(
      name: name ?? this.name,
      serviceId: serviceId ?? this.serviceId,
      subservices: subservices ?? this.subservices,
    );
  }
}

class MasterOwnSubserviceDto extends Dto
    implements JsonSerializer<MasterOwnSubserviceDto> {
  final int? subserviceId;
  final String? name;
  final int? time;
  final bool? isAvailable;
  final PricesDto? prices;
  final int? hairType;
  final String? serviceStatus;

  const MasterOwnSubserviceDto({
    this.subserviceId,
    this.name,
    this.time,
    this.isAvailable,
    this.prices,
    this.hairType,
    this.serviceStatus,
  });

  @override
  factory MasterOwnSubserviceDto.fromJson(Map<String, dynamic> json) {
    return MasterOwnSubserviceDto(
      subserviceId: json['subservice_id'] as int?,
      name: json['name'] as String?,
      time: json['time'] as int?,
      isAvailable: json['is_available'] as bool?,
      prices:
          json['prices'] != null ? PricesDto.fromJson(json['prices']) : null,
      hairType: json['hair_type'] as int?,
      serviceStatus: json['service_status'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (subserviceId != null) 'subservice_id': subserviceId,
      if (name != null) 'name': name,
      if (time != null) 'time': time,
      if (isAvailable != null) 'is_available': isAvailable,
      if (prices != null) 'prices': prices!.toJson(),
      if (hairType != null) 'hair_type': hairType,
      if (serviceStatus != null) 'service_status': serviceStatus,
    };
  }

  MasterOwnSubserviceDto copyWith({
    int? subserviceId,
    String? name,
    int? time,
    bool? isAvailable,
    PricesDto? prices,
    int? hairType,
    String? serviceStatus,
  }) {
    return MasterOwnSubserviceDto(
      subserviceId: subserviceId ?? this.subserviceId,
      name: name ?? this.name,
      time: time ?? this.time,
      isAvailable: isAvailable ?? this.isAvailable,
      prices: prices ?? this.prices,
      hairType: hairType ?? this.hairType,
      serviceStatus: serviceStatus ?? this.serviceStatus,
    );
  }
}

class PricesDto extends Dto implements JsonSerializer<PricesDto> {
  final int? min;
  final int? max;
  final int? fix;

  const PricesDto({
    this.min,
    this.max,
    this.fix,
  });

  @override
  factory PricesDto.fromJson(Map<String, dynamic> json) {
    return PricesDto(
      min: json['min'] as int?,
      max: json['max'] as int?,
      fix: json['fix'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (min != null) 'min': min,
      if (max != null) 'max': max,
      if (fix != null) 'fix': fix,
    };
  }

  PricesDto copyWith({
    int? min,
    int? max,
    int? fix,
  }) {
    return PricesDto(
      min: min ?? this.min,
      max: max ?? this.max,
      fix: fix ?? this.fix,
    );
  }
}
