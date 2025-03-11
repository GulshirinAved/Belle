import 'package:belle/src/core/core.dart';

import '../../../../shared.dart';

class ReferencesDto extends Dto implements JsonSerializer<ReferencesDto> {
  final List<CityDto>? cities;
  final List<GenderDto>? genders;
  final List<HolidayDto>? holidays;
  final List<LanguageDto>? languages;
  final List<LifetimeDto>? lifetimes;
  final List<LocationDto>? locations;
  final List<RegionDto>? regions;
  final List<BookingStatus>? bookingStatuses;

  const ReferencesDto({
    this.cities,
    this.genders,
    this.holidays,
    this.languages,
    this.lifetimes,
    this.locations,
    this.regions,
    this.bookingStatuses,
  });

  @override
  factory ReferencesDto.fromJson(Map<String, dynamic> json) {
    return ReferencesDto(
      cities: json['cities'] != null
          ? (json['cities'] as List)
              .map((e) => CityDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      genders: json['genders'] != null
          ? (json['genders'] as List)
              .map((e) => GenderDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      holidays: json['holidays'] != null
          ? (json['holidays'] as List)
              .map((e) => HolidayDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      languages: json['languages'] != null
          ? (json['languages'] as List)
              .map((e) => LanguageDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      lifetimes: json['lifetimes'] != null
          ? (json['lifetimes'] as List)
              .map((e) => LifetimeDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      locations: json['locations'] != null
          ? (json['locations'] as List)
              .map((e) => LocationDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      regions: json['regions'] != null
          ? (json['regions'] as List)
              .map((e) => RegionDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      bookingStatuses: json['booking_statuses'] != null
          ? (json['booking_statuses'] as List)
              .map((e) => BookingStatus.fromJson(e['id'] as int))
              .whereType<BookingStatus>()
              .toList()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'cities': cities?.map((e) => e.toJson()).toList(),
      'genders': genders?.map((e) => e.toJson()).toList(),
      'holidays': holidays?.map((e) => e.toJson()).toList(),
      'languages': languages?.map((e) => e.toJson()).toList(),
      'lifetimes': lifetimes?.map((e) => e.toJson()).toList(),
      'locations': locations?.map((e) => e.toJson()).toList(),
      'regions': regions?.map((e) => e.toJson()).toList(),
      'booking_statuses': bookingStatuses
          ?.map((e) => e.toJson())
          .toList(), // Добавлена обработка booking_statuses
    };
  }
}

class BookingStatusDto extends Dto implements JsonSerializer<BookingStatusDto> {
  final int? id;
  final String? name;

  const BookingStatusDto({this.id, this.name});

  @override
  factory BookingStatusDto.fromJson(Map<String, dynamic> json) {
    return BookingStatusDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class CityDto extends Dto implements JsonSerializer<CityDto> {
  final int? id;
  final String? name;

  const CityDto({this.id, this.name});

  @override
  factory CityDto.fromJson(Map<String, dynamic> json) {
    return CityDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GenderDto extends Dto implements JsonSerializer<GenderDto> {
  final int? id;
  final String? name;

  const GenderDto({this.id, this.name});

  @override
  factory GenderDto.fromJson(Map<String, dynamic> json) {
    return GenderDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class HolidayDto extends Dto implements JsonSerializer<HolidayDto> {
  final int? id;
  final String? name;

  const HolidayDto({this.id, this.name});

  @override
  factory HolidayDto.fromJson(Map<String, dynamic> json) {
    return HolidayDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class LanguageDto extends Dto implements JsonSerializer<LanguageDto> {
  final int? id;
  final String? name;

  const LanguageDto({this.id, this.name});

  @override
  factory LanguageDto.fromJson(Map<String, dynamic> json) {
    return LanguageDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class LifetimeDto extends Dto implements JsonSerializer<LifetimeDto> {
  final int? id;
  final String? name;

  const LifetimeDto({this.id, this.name});

  @override
  factory LifetimeDto.fromJson(Map<String, dynamic> json) {
    return LifetimeDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class LocationDto extends Dto implements JsonSerializer<LocationDto> {
  final int? id;
  final String? name;

  const LocationDto({this.id, this.name});

  @override
  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class RegionDto extends Dto implements JsonSerializer<RegionDto> {
  final int? id;
  final String? name;

  const RegionDto({this.id, this.name});

  @override
  factory RegionDto.fromJson(Map<String, dynamic> json) {
    return RegionDto(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
