abstract class RegisterDto {
  final String phone;

  const RegisterDto({
    required this.phone,
  });

  Map<String, dynamic> toJson();
}

class RegisterOnlyPhoneDto extends RegisterDto {
  const RegisterOnlyPhoneDto({required super.phone});

  @override
  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
    };
  }
}

class RegisterMainInfoDto extends RegisterDto {
  final int genderId;
  final bool readAgreement = true;
  final String personFn;

  const RegisterMainInfoDto({
    required super.phone,
    required this.genderId,
    required this.personFn,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "person_fn": personFn,
      "phone": phone,
      "id_c_gender": genderId,
      "read_agreement": readAgreement,
    };
  }
}

class RegisterClientDto extends RegisterMainInfoDto {
  const RegisterClientDto({
    required super.phone,
    required super.genderId,
    required super.personFn,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "person_fn": personFn,
      "phone": phone,
      "id_c_gender": genderId,
      "read_agreement": readAgreement,
    };
  }
}

class RegisterMasterDto extends RegisterMainInfoDto {
  final String personLn;
  final String password;
  final List<int> workingLocationIds;
  final int? serviceId;

  const RegisterMasterDto({
    required super.phone,
    required super.genderId,
    required super.personFn,
    required this.personLn,
    required this.password,
    required this.workingLocationIds,
    this.serviceId,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "person_fn": personFn,
      "person_ln": personLn,
      "phone": phone,
      "password": password,
      "id_c_gender": genderId,
      "id": workingLocationIds,
      "read_agreement": readAgreement,
      if (serviceId != null) "id_c_profile": serviceId,
    };
  }
}

class WorkingLocationLocal {
  final int id;
  final String title;

  const WorkingLocationLocal(this.id, this.title);

  static List<WorkingLocationLocal> get workingLocations => [
        const WorkingLocationLocal(1, 'in_salon'),
        const WorkingLocationLocal(2, 'away'),
      ];
}
