import '../../../../../../shared.dart';

class AccountDto {
  final int? id;
  final String? personFn;
  final String? personLn;
  final String? email;
  final String? phone;
  final String? address;
  final GenderDto? gender;
  final UserStatusDto? userStatus;
  final RoleDto? role;
  final bool? readAgreement;
  final AdditionalInfoDto? additionalInfo;

  const AccountDto({
    this.id,
    this.personFn,
    this.personLn,
    this.email,
    this.phone,
    this.address,
    this.gender,
    this.userStatus,
    this.role,
    this.readAgreement,
    this.additionalInfo,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(
      id: json['id'] as int?,
      personFn: json['person_fn'] as String?,
      personLn: json['person_ln'] as String?,
      email: json['_email'] as String?,
      phone: json['_phone'] as String?,
      address: json['address'] as String?,
      gender:
          json['gender'] != null ? GenderDto.fromJson(json['gender']) : null,
      userStatus: json['user_status'] != null
          ? UserStatusDto.fromJson(json['user_status'])
          : null,
      role: json['role'] != null ? RoleDto.fromJson(json['role']) : null,
      readAgreement: json['read_agreement'] as bool?,
      additionalInfo: json['additional_info'] != null
          ? AdditionalInfoDto.fromJson(json['additional_info'])
          : null,
    );
  }

  String get fullName => '${personFn ?? ''} ${personLn ?? ''}';
}

class AdditionalInfoDto {
  final String? aboutMe;
  final CityDto? city;
  final RegionDto? region;
  final String? description;
  final List<LanguageDto>? languages;
  final List<PortfolioItemDto>? portfolio;
  final String? userImage;
  final String? userImageName;
  final String? userImageType;
  final List<WorkingLocationDto>? workingLocations;

  const AdditionalInfoDto({
    this.aboutMe,
    this.city,
    this.region,
    this.description,
    this.languages,
    this.portfolio,
    this.userImage,
    this.userImageName,
    this.userImageType,
    this.workingLocations,
  });

  factory AdditionalInfoDto.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoDto(
      aboutMe: json['about_me'] as String?,
      city: json['city'] != null ? CityDto.fromJson(json['city']) : null,
      region:
          json['region'] != null ? RegionDto.fromJson(json['region']) : null,
      description: json['description'] as String?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => LanguageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      portfolio: (json['portfolio'] as List<dynamic>?)
          ?.map((e) => PortfolioItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      userImage: json['user_image'] as String?,
      userImageName: json['user_image_name'] as String?,
      userImageType: json['user_image_type'] as String?,
      workingLocations: (json['working_locations'] as List<dynamic>?)
          ?.map((e) => WorkingLocationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class UserStatusDto {
  final int? id;
  final String? name;

  const UserStatusDto({
    this.id,
    this.name,
  });

  factory UserStatusDto.fromJson(Map<String, dynamic> json) {
    return UserStatusDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

class RoleDto {
  final int? id;
  final String? name;

  const RoleDto({
    this.id,
    this.name,
  });

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}

// class LanguageDto {
//   final int? id;
//   final String? name;
//
//   const LanguageDto({
//     this.id,
//     this.name,
//   });
//
//   factory LanguageDto.fromJson(Map<String, dynamic> json) {
//     return LanguageDto(
//       id: json['id_c_lang'] as int?,
//       name: json['lang_name'] as String?,
//     );
//   }
// }

class PortfolioItemDto {
  final int? id;
  final String? imageUrl;
  final String? description;
  final String? createdAt;

  const PortfolioItemDto({
    this.id,
    this.imageUrl,
    this.description,
    this.createdAt,
  });

  factory PortfolioItemDto.fromJson(Map<String, dynamic> json) {
    return PortfolioItemDto(
      id: json['id'] as int?,
      imageUrl: json['image_url'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }
}

class WorkingLocationDto {
  final int? id;
  final String? name;

  const WorkingLocationDto({
    this.id,
    this.name,
  });

  factory WorkingLocationDto.fromJson(Map<String, dynamic> json) {
    return WorkingLocationDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }
}
