import '../../../../../../../../../shared.dart';

class RegisterClientOtpDto extends OtpDto {
  final RegisterClientDto? data;

  const RegisterClientOtpDto({
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
