import 'package:belle/src/core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../shared/shared.dart';

class MasterCalendarBookingDto extends Dto
    implements JsonSerializer<MasterCalendarBookingDto> {
  final int? bookingNumber;
  final ClientDto? client;
  final String? date;
  final String? time;
  final BookingStatus? status;
  final int? totalDuration;
  final num? totalPrice;
  final List<ServiceDto>? services;

  late DateTime from;
  late DateTime to;
  String get title => client?.fullName ?? '';
  Color get color {
    switch (status) {
      case BookingStatus.confirmed: // Подтверждено
        return AppColors.lightBlue;
      case BookingStatus.cancelled: // Отменено
        return AppColors.pink; // Используем красный для отмененных
      case BookingStatus.waiting: // В ожидании
        return AppColors.lightYellow;
      case BookingStatus.completed: // Завершена
        return AppColors.belleGray;
      case BookingStatus.reschedule: // Перенесена с отменой
        return AppColors
            .lightPink; // Используем красный для перенесенных с отменой
      case BookingStatus.clientArrived: // Перенесена с отменой
        return AppColors.lightGreen;
      default:
        return AppColors.belleGray; // По умолчанию серый
    }
  }

  MasterCalendarBookingDto({
    this.bookingNumber,
    this.client,
    this.date,
    this.time,
    this.status,
    this.totalDuration,
    this.totalPrice,
    this.services,
  }) {
    final dateParts = date?.split('-') ?? [];
    final timeParts = time?.split(':') ?? [];
    if (dateParts.length == 3 && timeParts.length == 2) {
      from = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
      to = from.add(Duration(minutes: totalDuration ?? 0));
    } else {
      from = DateTime.now();
      to = DateTime.now();
    }
  }

  @override
  factory MasterCalendarBookingDto.fromJson(Map<String, dynamic> json) {
    return MasterCalendarBookingDto(
      bookingNumber: json['booking_number'] as int?,
      client: json['client'] != null
          ? ClientDto.fromJson(json['client'] as Map<String, dynamic>)
          : null,
      date: json['date'] as String?,
      time: json['time'] as String?,
      status: BookingStatus.fromJson(json['status'] as int?),
      totalDuration: json['total_duration'] as int?,
      totalPrice: json['total_price'] as num?,
      services: json['services'] != null
          ? (json['services'] as List)
              .map((e) => ServiceDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'booking_number': bookingNumber,
      'client': client?.toJson(),
      'date': date,
      'time': time,
      'status': status,
      'total_duration': totalDuration,
      'total_price': totalPrice,
      'services': services?.map((e) => e.toJson()).toList(),
    };
  }
}

class ClientDto extends Dto implements JsonSerializer<ClientDto> {
  final int? id;
  final String? personFn;
  final String? personLn;
  final String? phone;

  const ClientDto({
    this.id,
    this.personFn,
    this.personLn,
    this.phone,
  });

  @override
  factory ClientDto.fromJson(Map<String, dynamic> json) {
    return ClientDto(
      id: json['id'] as int?,
      personFn: json['person_fn'] as String?,
      personLn: json['person_ln'] as String?,
      phone: json['phone'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person_fn': personFn,
      'person_ln': personLn,
      'phone': phone,
    };
  }

  String get fullName => '${personFn ?? ''} ${personLn ?? ''}';
}

class ServiceDto extends Dto implements JsonSerializer<ServiceDto> {
  final int? bookingId;
  final String? name;
  final int? duration;
  final num? price;

  const ServiceDto({
    this.bookingId,
    this.name,
    this.duration,
    this.price,
  });

  @override
  factory ServiceDto.fromJson(Map<String, dynamic> json) {
    return ServiceDto(
      bookingId: json['booking_id'] as int?,
      name: json['name'] as String?,
      duration: json['duration'] as int?,
      price: json['price'] as num?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'name': name,
      'duration': duration,
      'price': price,
    };
  }
}
