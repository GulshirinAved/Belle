import '../../../../../../../core/core.dart';

class TokenDto extends Dto implements JsonSerializer<TokenDto> {
  final String accessToken;
  final String refreshToken;

  const TokenDto({required this.accessToken, required this.refreshToken});

  @override
  factory TokenDto.fromJson(Map<String, dynamic> json) {
    return TokenDto(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "refresh_token": refreshToken,
    };
  }
}
