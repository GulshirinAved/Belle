import 'dart:developer';

import '../../../../../core/core.dart';

class MasterServiceDto extends Dto implements JsonSerializer<MasterServiceDto> {
  final int? id;
  final int? serviceId;
  final String? serviceName;
  final int? subserviceId;
  final String? subserviceName;
  final String? serviceForName;
  final int? idCServiceStatus;
  final int? minPrice;
  final int? maxPrice;
  final int? fixPrice;
  final int? time;
  final String? description;
  final bool? isMain;

  const MasterServiceDto({
    this.id,
    this.serviceId,
    this.serviceName,
    this.subserviceId,
    this.subserviceName,
    this.serviceForName,
    this.idCServiceStatus,
    this.minPrice,
    this.maxPrice,
    this.fixPrice,
    this.time,
    this.description,
    this.isMain,
  });

  /// Создание объекта из JSON
  @override
  factory MasterServiceDto.fromJson(Map<String, dynamic> json) {
    try {
      return MasterServiceDto(
        id: json['id_master_service'] as int?,
        serviceId: json['service_id'] as int?,
        serviceName: json['service_name'] as String?,
        subserviceId: json['subservice_id'] as int?,
        subserviceName: json['subservice_name'] as String?,
        serviceForName: json['service_for_name'] as String?,
        idCServiceStatus: json['id_c_service_status'] as int?,
        minPrice: json['min_price'] as int?,
        maxPrice: json['max_price'] as int?,
        fixPrice: json['fix_price'] as int?,
        time: json['time'] as int?,
        description: json['description'] as String?,
        isMain: json['is_main'] as bool?,
      );
    } catch (e) {
      log('Error parsing MasterServiceDto: $e');
      throw const FormatException('Invalid JSON format for MasterServiceDto');
    }
  }

  /// Преобразование объекта в JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id_master_service': id,
      'service_id': serviceId,
      'service_name': serviceName,
      'subservice_id': subserviceId,
      'subservice_name': subserviceName,
      'service_for_name': serviceForName,
      'id_c_service_status': idCServiceStatus,
      'min_price': minPrice,
      'max_price': maxPrice,
      'fix_price': fixPrice,
      'time': time,
      'description': description,
      'is_main': isMain,
    };
  }

  /// Метод для клонирования объекта
  MasterServiceDto copyWith({
    int? id,
    int? serviceId,
    String? serviceName,
    int? subserviceId,
    String? subserviceName,
    String? serviceForName,
    int? idCServiceStatus,
    int? minPrice,
    int? maxPrice,
    int? fixPrice,
    int? time,
    String? description,
    bool? isMain,
  }) {
    return MasterServiceDto(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      subserviceId: subserviceId ?? this.subserviceId,
      subserviceName: subserviceName ?? this.subserviceName,
      serviceForName: serviceForName ?? this.serviceForName,
      idCServiceStatus: idCServiceStatus ?? this.idCServiceStatus,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      fixPrice: fixPrice ?? this.fixPrice,
      time: time ?? this.time,
      description: description ?? this.description,
      isMain: isMain ?? this.isMain,
    );
  }
}
