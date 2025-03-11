import 'package:flutter/foundation.dart';

@immutable
class PaginationParams {
  final int? size;
  final int? number;

  const PaginationParams({this.size, this.number});

  Map<String, dynamic> toJson() {
    return {
      if (number != null) "page": number,
      if (size != null) "per_page": size,
    };
  }

  PaginationParams copyWith({
    int? size,
    int? number,
  }) {
    return PaginationParams(
      size: size ?? this.size,
      number: number ?? this.number,
    );
  }
}
