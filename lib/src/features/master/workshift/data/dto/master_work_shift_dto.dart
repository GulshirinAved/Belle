import 'package:flutter/foundation.dart';

@immutable
class MasterWorkShiftDto {
  final String? name;
  final List<int>? days;
  final String? dayStart;
  final String? dayEnd;
  final String? breakStart;
  final String? breakEnd;
  final String? startDate;
  final String? expiresDate;
  final int? idCWorkshiftLifetime;
  final int? workshiftDuration;
  final bool? isActive;
  final double? totalWorkHours;

  const MasterWorkShiftDto({
    this.name,
    this.days,
    this.dayStart,
    this.dayEnd,
    this.breakStart,
    this.breakEnd,
    this.startDate,
    this.expiresDate,
    this.idCWorkshiftLifetime,
    this.workshiftDuration,
    this.isActive,
    this.totalWorkHours,
  });

  factory MasterWorkShiftDto.fromJson(Map<String, dynamic> json) {
    return MasterWorkShiftDto(
      name: json['name'] as String?,
      days: (json['days'] as List<dynamic>?)?.map((e) => e as int).toList(),
      dayStart: json['day_start'] as String?,
      dayEnd: json['day_end'] as String?,
      breakStart: json['break_start'] as String?,
      breakEnd: json['break_end'] as String?,
      startDate: json['start_date'] as String?,
      expiresDate: json['expires_date'] as String?,
      idCWorkshiftLifetime: json['id_c_workshift_lifetime'] as int?,
      workshiftDuration: json['workshift_duration'] as int?,
      isActive: json['is_active'] as bool?,
      totalWorkHours: json['total_work_hours'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'day_start': dayStart,
      'day_end': dayEnd,
      'break_start': breakStart,
      'break_end': breakEnd,
      'start_date': startDate,
      'id_c_workshift_lifetime': idCWorkshiftLifetime,
    };
  }

  MasterWorkShiftDto copyWith({
    String? name,
    List<int>? days,
    String? dayStart,
    String? dayEnd,
    String? breakStart,
    String? breakEnd,
    String? startDate,
    String? expiresDate,
    int? idCWorkshiftLifetime,
    int? workshiftDuration,
    bool? isActive,
    double? totalWorkHours,
  }) {
    return MasterWorkShiftDto(
      name: name ?? this.name,
      days: days ?? this.days,
      dayStart: dayStart ?? this.dayStart,
      dayEnd: dayEnd ?? this.dayEnd,
      breakStart: breakStart ?? this.breakStart,
      breakEnd: breakEnd ?? this.breakEnd,
      startDate: startDate ?? this.startDate,
      expiresDate: expiresDate ?? this.expiresDate,
      idCWorkshiftLifetime: idCWorkshiftLifetime ?? this.idCWorkshiftLifetime,
      workshiftDuration: workshiftDuration ?? this.workshiftDuration,
      isActive: isActive ?? this.isActive,
      totalWorkHours: totalWorkHours ?? this.totalWorkHours,
    );
  }
}
