import 'package:belle/src/core/core.dart';

class MasterCalendarFreeSlotsDto extends Dto
    implements JsonSerializer<MasterCalendarFreeSlotsDto> {
  final List<String>? availableSlots;
  final List<String>? disabledSlots;

  const MasterCalendarFreeSlotsDto({
    this.availableSlots,
    this.disabledSlots,
  });

  @override
  factory MasterCalendarFreeSlotsDto.fromJson(Map<String, dynamic> json) {
    return MasterCalendarFreeSlotsDto(
      availableSlots: json['available_slots'] != null
          ? List<String>.from(json['available_slots'])
          : null,
      disabledSlots: json['disabled_slots'] != null
          ? List<String>.from(json['disabled_slots'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'available_slots': availableSlots,
      'disabled_slots': disabledSlots,
    };
  }
}
