abstract class LoginDto {
  final String phone;

  const LoginDto({required this.phone});

  Map<String, dynamic> toJson();
}

class LoginClientDto extends LoginDto {
  const LoginClientDto({required super.phone});

  @override
  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
    };
  }
}

class LoginMasterDto extends LoginDto {
  final String password;
  const LoginMasterDto({required super.phone, required this.password});

  @override
  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "password": password,
    };
  }
}
