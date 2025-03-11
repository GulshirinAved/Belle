import '../../../../../../../../../shared.dart';

class RegisterMasterOtpDto extends OtpDto {
  final RegisterMasterDto? data;

  const RegisterMasterOtpDto({
    required this.data,
    required super.code,
    // required super.deviceType,
  });

  @override
  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    jsonData.addAll(data?.toJson() ?? {});
    jsonData.addAll({"code": code});
    // jsonData.addAll({"device_type": deviceType});
    return jsonData;
  }
}
