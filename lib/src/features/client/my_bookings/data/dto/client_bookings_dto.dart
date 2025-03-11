import 'package:flutter/foundation.dart';

import '../../../../shared/shared.dart';
import '../../../client.dart';

/// Модель ClientBookingsDto
@immutable
class ClientBookingsDto {
  final int? bookingNumber;
  final Master? master;
  final String? date;
  final String? time;
  final BookingStatus status;
  final int? totalDuration;
  final int? totalPrice;
  final List<Services>? services;
  final String? address;

  const ClientBookingsDto({
    this.bookingNumber,
    this.master,
    this.date,
    this.time,
    this.status = BookingStatus.notFound,
    this.totalDuration,
    this.totalPrice,
    this.services,
    this.address,
  });

  factory ClientBookingsDto.fromJson(Map<String, dynamic> json) {
    return ClientBookingsDto(
      bookingNumber: json['booking_number'] as int?,
      master: json['master'] != null ? Master.fromJson(json['master']) : null,
      date: json['date'] as String?,
      time: json['time'] as String?,
      status: BookingStatus.fromJson(json['status'] as int?),
      totalDuration: json['total_duration'] as int?,
      totalPrice: json['total_price'] as int?,
      services: json['services'] != null
          ? (json['services'] as List)
              .map((item) => Services.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_number': bookingNumber,
      'master': master?.toJson(),
      'date': date,
      'time': time,
      'status': status,
      'total_duration': totalDuration,
      'total_price': totalPrice,
      'services': services?.map((item) => item.toJson()).toList(),
    };
  }
}
