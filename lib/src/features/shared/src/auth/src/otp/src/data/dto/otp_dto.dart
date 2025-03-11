abstract class OtpDto {
  final String code;

  // final String deviceType;

  const OtpDto({
    required this.code,
    // required this.deviceType,
  });

  Map<String, dynamic> toJson();
}
