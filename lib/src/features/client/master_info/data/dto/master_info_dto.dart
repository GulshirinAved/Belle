class ClientMasterInfoDto {
  const ClientMasterInfoDto({
    this.aboutMe,
    this.avgRating,
    this.id,
    this.personFn,
    this.personLn,
    this.portfolio,
    this.profileId,
    this.profileName,
    this.reviewsCount,
    this.services,
    this.userImage,
    this.workshifts,
    this.address,
    this.cityId,
    this.cityName,
    this.gender,
    this.genderId,
    this.languages,
    this.regionId,
    this.regionName,
    this.userStatus,
    this.userStatusId,
    this.workingLocations,
  });

  final String? aboutMe;
  final num? avgRating;
  final int? id;
  final String? personFn;
  final String? personLn;
  final List<PortfolioItem>? portfolio;
  final int? profileId;
  final String? profileName;
  final int? reviewsCount;
  final List<ClientMasterServiceDto>? services;
  final String? userImage;
  final List<Workshift>? workshifts;
  final String? address;
  final int? cityId;
  final String? cityName;
  final String? gender;
  final int? genderId;
  final List<Language>? languages;
  final int? regionId;
  final String? regionName;
  final String? userStatus;
  final int? userStatusId;
  final List<WorkingLocation>? workingLocations;

  factory ClientMasterInfoDto.fromJson(Map<String, dynamic> json) {
    return ClientMasterInfoDto(
      aboutMe: json['about_me'],
      avgRating: json['avg_rating'],
      id: json['id'],
      personFn: json['person_fn'],
      personLn: json['person_ln'],
      portfolio: json['portfolio'] == null
          ? []
          : List<PortfolioItem>.from(
              json['portfolio'].map((x) => PortfolioItem.fromJson(x)),
            ),
      profileId: json['profile_id'],
      profileName: json['profile_name'],
      reviewsCount: json['reviews_count'],
      services: json['services'] == null
          ? []
          : List<ClientMasterServiceDto>.from(
              json['services'].map((x) => ClientMasterServiceDto.fromJson(x)),
            ),
      userImage: json['user_image'],
      workshifts: json['workshifts'] == null
          ? []
          : List<Workshift>.from(
              json['workshifts'].map((x) => Workshift.fromJson(x)),
            ),
      address: json['address'],
      cityId: json['city_id'],
      cityName: json['city_name'],
      gender: json['gender'],
      genderId: json['gender_id'],
      languages: json['languages'] == null
          ? []
          : List<Language>.from(
              json['languages'].map((x) => Language.fromJson(x)),
            ),
      regionId: json['region_id'],
      regionName: json['region_name'],
      userStatus: json['user_status'],
      userStatusId: json['user_status_id'],
      workingLocations: json['working_locations'] == null
          ? []
          : List<WorkingLocation>.from(
              json['working_locations'].map((x) => WorkingLocation.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        'about_me': aboutMe,
        'avg_rating': avgRating,
        'id': id,
        'person_fn': personFn,
        'person_ln': personLn,
        'portfolio': portfolio?.map((x) => x.toJson()).toList(),
        'profile_id': profileId,
        'profile_name': profileName,
        'reviews_count': reviewsCount,
        'services': services?.map((x) => x.toJson()).toList(),
        'user_image': userImage,
        'workshifts': workshifts?.map((x) => x.toJson()).toList(),
        'address': address,
        'city_id': cityId,
        'city_name': cityName,
        'gender': gender,
        'gender_id': genderId,
        'languages': languages?.map((x) => x.toJson()).toList(),
        'region_id': regionId,
        'region_name': regionName,
        'user_status': userStatus,
        'user_status_id': userStatusId,
        'working_locations': workingLocations?.map((x) => x.toJson()).toList(),
      };

  List<int?> get workingLocationsIds =>
      workingLocations
          ?.map((location) => location.workingLocationId)
          .toList() ??
      <int>[];

  String get fullName => '${personFn ?? ''} ${personLn ?? ''}'.trim();
}

class Language {
  const Language({
    this.langId,
    this.langName,
  });

  final int? langId;
  final String? langName;

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      langId: json['lang_id'],
      langName: json['lang_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'lang_id': langId,
        'lang_name': langName,
      };
}

class WorkingLocation {
  const WorkingLocation({
    this.workingLocationId,
    this.workingLocationName,
  });

  final int? workingLocationId;
  final String? workingLocationName;

  factory WorkingLocation.fromJson(Map<String, dynamic> json) {
    return WorkingLocation(
      workingLocationId: json['working_location_id'],
      workingLocationName: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'working_location_id': workingLocationId,
        'name': workingLocationName,
      };
}

class PortfolioItem {
  const PortfolioItem({
    this.createdAt,
    this.id,
    this.imageName,
    this.imageType,
    this.imageUrl,
  });

  final DateTime? createdAt;
  final int? id;
  final String? imageName;
  final String? imageType;
  final String? imageUrl;

  factory PortfolioItem.fromJson(Map<String, dynamic> json) {
    return PortfolioItem(
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      id: json['id'],
      imageName: json['image_name'],
      imageType: json['image_type'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'created_at': createdAt?.toIso8601String(),
        'id': id,
        'image_name': imageName,
        'image_type': imageType,
        'image_url': imageUrl,
      };
}

class Workshift {
  const Workshift({
    this.breakEnd,
    this.breakStart,
    this.dayEnd,
    this.dayStart,
    this.days,
  });

  final String? breakEnd;
  final String? breakStart;
  final String? dayEnd;
  final String? dayStart;
  final int? days;

  factory Workshift.fromJson(Map<String, dynamic> json) {
    return Workshift(
      breakEnd: json['break_end'],
      breakStart: json['break_start'],
      dayEnd: json['day_end'],
      dayStart: json['day_start'],
      days: json['days'],
    );
  }

  Map<String, dynamic> toJson() => {
        'break_end': breakEnd,
        'break_start': breakStart,
        'day_end': dayEnd,
        'day_start': dayStart,
        'days': days,
      };
}

class ClientMasterServiceDto {
  const ClientMasterServiceDto({
    this.serviceId,
    this.name,
    this.subservices,
  });

  final int? serviceId;
  final String? name;
  final List<Subservice>? subservices;

  factory ClientMasterServiceDto.fromJson(Map<String, dynamic> json) {
    return ClientMasterServiceDto(
      serviceId: json['service_id'],
      name: json['name'],
      subservices: json['subservices'] == null
          ? []
          : List<Subservice>.from(
              json['subservices'].map((x) => Subservice.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        'service_id': serviceId,
        'name': name,
        'subservices': subservices?.map((x) => x.toJson()).toList(),
      };
}

class Subservice {
  const Subservice({
    this.hairType,
    this.subserviceId,
    this.name,
    this.prices,
    this.time,
  });

  final int? hairType;
  final int? subserviceId;
  final String? name;
  final Prices? prices;
  final int? time;

  factory Subservice.fromJson(Map<String, dynamic> json) {
    return Subservice(
      hairType: json['hair_type'],
      subserviceId: json['subservice_id'],
      name: json['name'],
      prices: json['prices'] == null ? null : Prices.fromJson(json['prices']),
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() => {
        'hair_type': hairType,
        'subservice_id': subserviceId,
        'name': name,
        'prices': prices?.toJson(),
        'time': time,
      };
}

class Prices {
  const Prices({
    this.fix,
    this.max,
    this.min,
  });

  final num? fix;
  final num? max;
  final num? min;

  factory Prices.fromJson(Map<String, dynamic> json) {
    return Prices(
      fix: json['fix'],
      max: json['max'],
      min: json['min'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fix': fix,
        'max': max,
        'min': min,
      };

  String get price => fix != null ? '$fix' : '$min - $max';
}
