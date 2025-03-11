import 'package:flutter/material.dart';

@immutable
class CalendarResponseModel {
  final CalendarModel? calendar;
  final List<ServiceModel>? services;
  final TotalsModel? totals;

  const CalendarResponseModel({
    this.calendar,
    this.services,
    this.totals,
  });

  factory CalendarResponseModel.fromJson(Map<String, dynamic> json) {
    return CalendarResponseModel(
      calendar: json['calendar'] != null
          ? CalendarModel.fromJson(json['calendar'])
          : null,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e))
          .toList(),
      totals:
          json['totals'] != null ? TotalsModel.fromJson(json['totals']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calendar': calendar?.toJson(),
      'services': services?.map((e) => e.toJson()).toList(),
      'totals': totals?.toJson(),
    };
  }
}

@immutable
class CalendarModel {
  final List<DateModel>? dates;
  final int? totalDuration;

  const CalendarModel({
    this.dates,
    this.totalDuration,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      dates: (json['dates'] as List<dynamic>?)
          ?.map((e) => DateModel.fromJson(e))
          .toList(),
      totalDuration: json['total_duration'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dates': dates?.map((e) => e.toJson()).toList(),
      'total_duration': totalDuration,
    };
  }
}

@immutable
class DateModel {
  final DateTime? date;
  final bool? isAvailable;
  final String? reason;
  final List<TimeOfDay>? availableSlots;
  final List<TimeOfDay>? disabledSlots;

  const DateModel({
    this.date,
    this.isAvailable,
    this.reason,
    this.availableSlots,
    this.disabledSlots,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) {
    final availableSlots =
        (json['available_slots'] as List<dynamic>?)?.map((time) {
      final parts = (time.toString()).split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }).toList();
    final disabledSlots =
        (json['disabled_slots'] as List<dynamic>?)?.map((time) {
      final parts = (time.toString()).split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }).toList();
    final date = json['date'] != null ? DateTime.parse(json['date']) : null;
    return DateModel(
      date: date,
      isAvailable: json['is_available'] as bool?,
      reason: json['reason'] as String?,
      availableSlots: availableSlots,
      disabledSlots: disabledSlots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'is_available': isAvailable,
      'reason': reason,
      'available_slots': availableSlots
          ?.map((slot) =>
              '${slot.hour}:${slot.minute.toString().padLeft(2, '0')}')
          .toList(),
      'disabled_slots': disabledSlots
          ?.map((slot) =>
              '${slot.hour}:${slot.minute.toString().padLeft(2, '0')}')
          .toList(),
    };
  }
}

@immutable
class ServiceModel {
  final int? id;
  final String? subserviceName;
  final int? subserviceId;
  final String? hairTypeName;
  final int? fixPrice;
  final int? maxPrice;
  final int? minPrice;
  final int? time;

  const ServiceModel({
    this.id,
    this.subserviceName,
    this.subserviceId,
    this.hairTypeName,
    this.fixPrice,
    this.maxPrice,
    this.minPrice,
    this.time,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int?,
      subserviceName: json['subservice_name'] as String?,
      subserviceId: json['subservice_id'] as int?,
      hairTypeName: json['hair_type_name'] as String?,
      fixPrice: json['fix_price'] as int?,
      maxPrice: json['max_price'] as int?,
      minPrice: json['min_price'] as int?,
      time: json['time'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subservice_name': subserviceName,
      'subservice_id': subserviceId,
      'hair_type_name': hairTypeName,
      'fix_price': fixPrice,
      'max_price': maxPrice,
      'min_price': minPrice,
      'time': time,
    };
  }
}

@immutable
class TotalsModel {
  final int? totalPriceFix;
  final int? totalPriceMax;
  final int? totalPriceMin;
  final int? totalTime;

  const TotalsModel({
    this.totalPriceFix,
    this.totalPriceMax,
    this.totalPriceMin,
    this.totalTime,
  });

  factory TotalsModel.fromJson(Map<String, dynamic> json) {
    return TotalsModel(
      totalPriceFix: json['total_price_fix'] as int?,
      totalPriceMax: json['total_price_max'] as int?,
      totalPriceMin: json['total_price_min'] as int?,
      totalTime: json['total_time'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_price_fix': totalPriceFix,
      'total_price_max': totalPriceMax,
      'total_price_min': totalPriceMin,
      'total_time': totalTime,
    };
  }
}
