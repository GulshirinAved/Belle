import '../../../client.dart';

class ClientMasterDto {
  final num? avgRating;
  // final String? image;
  final num? masterId;
  final String? personFn;
  final String? personLn;
  final num? profileId;
  final String? profileName;
  final String? registeredAt;
  final num? subscriptionId;
  final String? subscriptionName;
  final num? totalScore;
  final String? userStatus;
  final List<String?>? portfolioImages;

  const ClientMasterDto({
    this.avgRating,
    // this.image,
    this.masterId,
    this.personFn,
    this.personLn,
    this.profileId,
    this.profileName,
    this.registeredAt,
    this.subscriptionId,
    this.subscriptionName,
    this.totalScore,
    this.userStatus,
    this.portfolioImages,
  });

  factory ClientMasterDto.fromJson(Map<String, dynamic> json) {
    return ClientMasterDto(
      avgRating: json['avg_rating'] as num?,
      // image: json['image'] as String?,
      masterId: json['master_id'] as num?,
      personFn: json['person_fn'] as String?,
      personLn: json['person_ln'] as String?,
      profileId: json['profile_id'] as num?,
      profileName: json['profile_name'] as String?,
      registeredAt: json['registered_at'] as String?,
      subscriptionId: json['subscription_id'] as num?,
      subscriptionName: json['subscription_name'] as String?,
      totalScore: json['total_score'] as num?,
      userStatus: json['user_status'] as String?,
      portfolioImages: (json['portfolio_images'] as Iterable?)
              ?.map((el) => el as String?)
              .toList() ??
          [],
    );
  }

  factory ClientMasterDto.fromClientMasterInfoDto(
      ClientMasterInfoDto? infoDto) {
    return ClientMasterDto(
      avgRating: infoDto?.avgRating,
      // image: infoDto?.userImage,
      masterId: infoDto?.id,
      personFn: infoDto?.personFn,
      personLn: infoDto?.personLn,
      profileId: infoDto?.profileId,
      profileName: infoDto?.profileName,
      // `registeredAt`, `subscriptionId`, `subscriptionName`, `totalScore`, `userStatus`
      // можно оставить `null`, если они отсутствуют в `ClientMasterInfoDto`.
      registeredAt: null,
      subscriptionId: null,
      subscriptionName: null,
      totalScore: null,
      userStatus: null,
    );
  }

  String? get image =>
      (portfolioImages?.isEmpty ?? true) ? null : portfolioImages?.first;

  String get fullName => '${personFn ?? ''} ${personLn ?? ''}';
}
