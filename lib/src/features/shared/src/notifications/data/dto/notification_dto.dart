import 'dart:convert';
import 'dart:developer';

import '../../../../../../core/core.dart';
import '../../../../shared.dart';

abstract class NotificationDto extends Dto
    implements JsonSerializer<NotificationDto> {
  final String type;

  const NotificationDto({required this.type});

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('type')) {
      throw Exception('NotificationDto must have a type field');
    }
    try {
      final type = json['type'] as String?;
      if (type == 'booking') {
        return NotificationBookingInfoDto.fromJson(json);
      } else {
        return NotificationSystemDto.fromJson(json);
      }
    } on Exception catch (e) {
      log('NotificationDto fromJson exception: $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson();
}

class NotificationSystemDto extends NotificationDto {
  const NotificationSystemDto({required super.type});

  factory NotificationSystemDto.fromJson(Map<String, dynamic> json) {
    return NotificationSystemDto(
      type: json['type'] as String,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

class NotificationBookingInfoDto extends NotificationDto {
  final String? bookingNumber;
  final NotificationClientDto? client;
  final String? date;
  final String? time;
  final BookingStatus? status;
  final String? totalDuration;
  final String? totalPrice;
  final List<NotificationServiceDto>? services;
  final String? initiatorId;

  NotificationBookingInfoDto({
    required super.type,
    this.bookingNumber,
    this.client,
    this.date,
    this.time,
    this.status,
    this.totalDuration,
    this.totalPrice,
    this.services,
    this.initiatorId,
    // this.bookingStatus,
  });

  factory NotificationBookingInfoDto.fromJson(Map<String, dynamic> json) {
    log('Printing json inside NotificationBookingInfoDto: $json');

    try {
      return NotificationBookingInfoDto(
        type: json['notification']?['type']?.toString() ?? '',
        bookingNumber: json['booking_number']?.toString(),
        client: json['client'] != null
            ? NotificationClientDto.fromJson(json['client'] is String
                ? jsonDecode(json['client'])
                : json['client'])
            : null,
        date: json['date']?.toString(),
        time: json['time']?.toString(),
        status: json['status'] != null
            ? BookingStatus.fromJson(
                int.tryParse(json['status'].toString()) ?? -1)
            : null,
        totalDuration: json['total_duration']?.toString(),
        totalPrice: json['total_price']?.toString(),
        initiatorId: json['initiator_id']?.toString(),
        services: json['services'] != null
            ? (json['services'] is List
                ? (json['services'] as List)
                    .map((e) => NotificationServiceDto.fromJson(
                        e is String ? jsonDecode(e) : e))
                    .toList()
                : jsonDecode(json['services'] as String))
            : null,
      );
    } on Exception catch (e) {
      log('NotificationBookingInfoDto fromJson exception: $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'booking_number': bookingNumber,
      'client': client?.toJson(),
      'date': date,
      'time': time,
      'status': status,
      'total_duration': totalDuration,
      'total_price': totalPrice,
      'initiator_id': initiatorId,
      'services': services?.map((e) => e.toJson()).toList(),
    };
  }
}

class NotificationClientDto extends Dto
    implements JsonSerializer<NotificationClientDto> {
  final String? id;
  final String? personFn;
  final String? personLn;
  final String? phone;

  const NotificationClientDto({
    this.id,
    this.personFn,
    this.personLn,
    this.phone,
  });

  @override
  factory NotificationClientDto.fromJson(Map<String, dynamic> json) {
    return NotificationClientDto(
      id: json['id']?.toString(),
      personFn: json['person_fn'] as String?,
      personLn: json['person_ln'] as String? ?? '',
      phone: json['phone']?.toString(),
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

class NotificationServiceDto extends Dto
    implements JsonSerializer<NotificationServiceDto> {
  final String? bookingId;
  final String? name;
  final String? duration;
  final String? price;

  const NotificationServiceDto({
    this.bookingId,
    this.name,
    this.duration,
    this.price,
  });

  @override
  factory NotificationServiceDto.fromJson(Map<String, dynamic> json) {
    return NotificationServiceDto(
      bookingId: json['booking_id']?.toString(),
      name: json['name'] as String?,
      duration: json['duration']?.toString(),
      price: json['price']?.toString(),
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
