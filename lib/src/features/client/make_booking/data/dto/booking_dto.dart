import 'package:flutter/foundation.dart';

@immutable
class BookingDto {
  final int? masterId;
  final String? date;
  final String? time;
  final List<int?>? subserviceIds;
  final String? clientPersonFn;
  final String? clientPhone;
  final int? bookingLocationId;

  const BookingDto({
    this.masterId,
    this.date,
    this.time,
    this.subserviceIds,
    this.clientPersonFn,
    this.clientPhone,
    this.bookingLocationId,
  });

  BookingDto copyWith({
    int? masterId,
    String? date,
    String? time,
    List<int>? subserviceIds,
    String? clientPersonFn,
    String? clientPhone,
    int? bookingLocationId,
  }) {
    return BookingDto(
      masterId: masterId ?? this.masterId,
      date: date ?? this.date,
      time: time ?? this.time,
      subserviceIds: subserviceIds ?? this.subserviceIds,
      clientPersonFn: clientPersonFn ?? this.clientPersonFn,
      clientPhone: clientPhone ?? this.clientPhone,
      bookingLocationId: bookingLocationId ?? this.bookingLocationId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'master_id': masterId,
      'date': date,
      'time': time,
      'subservice_ids': subserviceIds,
      'client_person_fn': clientPersonFn,
      'client_phone': clientPhone,
      'booking_location_id': bookingLocationId,
    };
  }
}