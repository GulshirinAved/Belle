import 'package:flutter/material.dart';

@immutable
class MasterBookingsParams {
  final int year;
  final int month;
  final int day;

  const MasterBookingsParams({
    required this.year,
    required this.month,
    required this.day,
  });

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "month": month,
      "day": day,
    };
  }

  MasterBookingsParams copyWith({
    int? year,
    int? month,
    int? day,
  }) {
    return MasterBookingsParams(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is MasterBookingsParams) {
      return year == other.year && month == other.month && day == other.day;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(runtimeType, super.hashCode);
}
