import '../../../../../../../core/core.dart';

class ServiceDetailedDto extends Dto
    implements JsonSerializer<ServiceDetailedDto> {
  final int? serviceId;
  final String? name;
  final String? iconPath;
  final List<SubserviceDto>? subservices;

  const ServiceDetailedDto({
    this.serviceId,
    this.name,
    this.iconPath,
    this.subservices,
  });

  @override
  factory ServiceDetailedDto.fromJson(Map<String, dynamic> json) {
    return ServiceDetailedDto(
      serviceId: json['service_id'] as int?,
      name: json['name'] as String?,
      iconPath: json['icon_path'] as String?,
      subservices: (json['subservices'] as List<dynamic>?)
          ?.map((e) => SubserviceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'name': name,
      'icon_path': iconPath,
      'subservices': subservices?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubserviceDto extends Dto implements JsonSerializer<SubserviceDto> {
  final int? id;
  final String? name;
  final int? serviceFor;

  const SubserviceDto({
    this.id,
    this.name,
    this.serviceFor,
  });

  @override
  factory SubserviceDto.fromJson(Map<String, dynamic> json) {
    return SubserviceDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      serviceFor: json['service_for'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'service_for': serviceFor,
    };
  }
}
