import 'package:flutter/foundation.dart';

@immutable
class ClientMasterReviewsParams {
  final int? masterId;
  final int? size;
  final int? number;

  const ClientMasterReviewsParams({
    required this.masterId,
    this.size,
    this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      "master_id": masterId,
      if (size != null) "per_page": size,
      if (number != null) "page": number,
    };
  }

  ClientMasterReviewsParams copyWith({
    int? masterId,
    int? size,
    int? number,
  }) {
    return ClientMasterReviewsParams(
      masterId: masterId ?? this.masterId,
      size: size ?? this.size,
      number: number ?? this.number,
    );
  }
}
