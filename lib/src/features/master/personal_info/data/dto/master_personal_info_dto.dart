import 'package:equatable/equatable.dart';

import '../../../../shared/shared.dart';

class MasterPersonalInfoDto extends Equatable {
  final String? personFn;
  final String? personLn;
  final String? email;
  final String? phone;
  final int? idCGender;
  final int? idCCity;
  final int? idCRegion;
  final String? description;
  final String? address;
  final List<int>? languages;
  final List<int>? workingLocations;

  const MasterPersonalInfoDto({
    this.personFn,
    this.personLn,
    this.email,
    this.phone,
    this.idCGender,
    this.idCCity,
    this.idCRegion,
    this.description,
    this.address,
    this.languages,
    this.workingLocations,
  });

  factory MasterPersonalInfoDto.fromAccountDto(AccountDto account) {
    return MasterPersonalInfoDto(
      personFn: account.personFn,
      personLn: account.personLn,
      email: account.email,
      phone: account.phone,
      idCGender: account.gender?.id,
      idCCity: account.additionalInfo?.city?.id,
      idCRegion: account.additionalInfo?.region?.id,
      description: account.additionalInfo?.description,
      address: account.address,
      languages:
          account.additionalInfo?.languages?.map((e) => e.id ?? 0).toList(),
      workingLocations: account.additionalInfo?.workingLocations
          ?.map((e) => e.id ?? 0)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (personFn != null && personFn!.isNotEmpty) 'person_fn': personFn,
      if (personLn != null && personLn!.isNotEmpty) 'person_ln': personLn,
      if (email != null && email!.isNotEmpty) '_email': email,
      if (phone != null && phone!.isNotEmpty) '_phone': phone,
      if (idCGender != null) 'id_c_gender': idCGender,
      if (idCCity != null) 'id_c_city': idCCity,
      if (idCRegion != null) 'id_c_region': idCRegion,
      if (description != null && description!.isNotEmpty)
        'description': description,
      if (address != null && address!.isNotEmpty) 'address': address,
      if (languages != null && languages!.isNotEmpty) 'languages': languages,
      if (workingLocations != null && workingLocations!.isNotEmpty)
        'working_locations': workingLocations,
    };
  }

  @override
  List<Object?> get props => [
        personFn,
        personLn,
        email,
        phone,
        idCGender,
        idCCity,
        idCRegion,
        description,
        address,
        languages,
        workingLocations,
      ];
}
