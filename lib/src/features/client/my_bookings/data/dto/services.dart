import 'package:flutter/foundation.dart';

@immutable
class Services {
  final int? bookingId;
  final String? name;
  final int? duration;
  final int? price;

  const Services({
    this.bookingId,
    this.name,
    this.duration,
    this.price,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      bookingId: json['booking_id'] as int?,
      name: json['name'] as String?,
      duration: json['duration'] as int?,
      price: json['price'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'name': name,
      'duration': duration,
      'price': price,
    };
  }
}
