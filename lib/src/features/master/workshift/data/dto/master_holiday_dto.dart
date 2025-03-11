import 'package:flutter/foundation.dart';

@immutable
class MasterHolidayDto {
  final int? id;
  final String? dateStart;
  final String? dateEnd;
  final String? reason;
  final int? reasonId;

  const MasterHolidayDto(
      {this.id, this.dateStart, this.dateEnd, this.reason, this.reasonId});

  factory MasterHolidayDto.fromJson(Map<String, dynamic> json) {
    return MasterHolidayDto(
      id: json['id'] as int?,
      dateStart: json['date_start'] as String?,
      dateEnd: json['date_end'] as String?,
      reason: json['description'] as String?,
      reasonId: json['id_c_holidays'] as int?,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     if (dateStart != null)
  //       'date_start': dateStart!.toIso8601String().split('T').first,
  //     if (dateEnd != null)
  //       'date_end': dateEnd!.toIso8601String().split('T').first,
  //     if (reason != null) 'reason': reason,
  //   };
  // }
}

@immutable
class MasterHolidayToSendDto {
  final int? reasonId;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final String? reason;

  const MasterHolidayToSendDto({
    this.reasonId,
    this.dateStart,
    this.dateEnd,
    this.reason,
  });

  // factory MasterHolidayToSendDto.fromJson(Map<String, dynamic> json) {
  //   return MasterHolidayToSendDto(
  //     id: json['id'] as int?,
  //     dateStart: json['date_start'] != null
  //         ? DateTime.tryParse(json['date_start'])
  //         : null,
  //     dateEnd:
  //         json['date_end'] != null ? DateTime.tryParse(json['date_end']) : null,
  //     reason: json['reason'] as String?,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      if (reasonId != null) 'id_c_holidays': reasonId,
      if (dateStart != null)
        'date_start': dateStart!.toIso8601String().split('T').first,
      if (dateEnd != null)
        'date_end': dateEnd!.toIso8601String().split('T').first,
      if (reason != null) 'description': reason,
    };
  }
}
