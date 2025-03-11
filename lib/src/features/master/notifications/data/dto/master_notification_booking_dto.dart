import 'dart:ui';

import 'package:belle/src/core/core.dart';

import '../../../../../theme/theme.dart';
import '../../../../shared/shared.dart';
import '../../../master.dart';

class MasterNotificationBookingDto extends Dto
    implements JsonSerializer<MasterNotificationBookingDto> {
  final int? bookingNumber;
  final ClientDto? client;
  final String? date;
  final BookingStatus? status;
  final int? initiatorId;
  final MasterNotification? notification;
  final String? time;
  final int? totalDuration;
  final num? totalPrice;
  final List<ServiceDto>? services;

  const MasterNotificationBookingDto({
    this.bookingNumber,
    this.client,
    this.date,
    this.status,
    this.initiatorId,
    this.notification,
    this.time,
    this.totalDuration,
    this.totalPrice,
    this.services,
  });

  @override
  factory MasterNotificationBookingDto.fromJson(Map<String, dynamic> json) {
    return MasterNotificationBookingDto(
      bookingNumber: json['booking_number'] as int?,
      client:
          json['client'] != null ? ClientDto.fromJson(json['client']) : null,
      date: json['date'] as String?,
      status: BookingStatus.fromJson(json['status'] as int?),
      initiatorId: json['initiator_id'] as int?,
      notification: json['notification'] != null
          ? MasterNotification.fromJson(json['notification'])
          : null,
      time: json['time'] as String?,
      totalDuration: json['total_duration'] as int?,
      totalPrice: json['total_price'] as num?,
      services: json['services'] != null
          ? (json['services'] as List)
              .map((e) => ServiceDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

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
        return AppColors
            .lightGreen; // Используем красный для перенесенных с отменой
      default:
        return AppColors.belleGray; // По умолчанию серый
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'booking_number': bookingNumber,
      'client': client?.toJson(),
      'date': date,
      'status': status,
      'initiator_id': initiatorId,
      'notification': notification?.toJson(),
      'time': time,
      'total_duration': totalDuration,
      'total_price': totalPrice,
    };
  }
}

class MasterNotification extends Dto
    implements JsonSerializer<MasterNotification> {
  final String? createdAt;
  final int? id;
  final bool? isRead;
  final String? lastUpdate;
  final String? readAt;
  final int? type;

  const MasterNotification({
    this.createdAt,
    this.id,
    this.isRead,
    this.lastUpdate,
    this.readAt,
    this.type,
  });

  @override
  factory MasterNotification.fromJson(Map<String, dynamic> json) {
    return MasterNotification(
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
      isRead: json['is_read'] as bool?,
      lastUpdate: json['last_update'] as String?,
      readAt: json['read_at'] as String?,
      type: json['type'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'id': id,
      'is_read': isRead,
      'last_update': lastUpdate,
      'read_at': readAt,
      'type': type,
    };
  }
}
