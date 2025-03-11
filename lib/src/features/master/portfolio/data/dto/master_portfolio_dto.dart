import 'dart:developer';

import 'package:belle/src/core/core.dart';

class MasterPortfolioDto extends Dto
    implements JsonSerializer<MasterPortfolioDto> {
  final int? id;
  final String? imageUrl;
  final String? description;
  final DateTime? createdAt;

  const MasterPortfolioDto({
    this.id,
    this.imageUrl,
    this.description,
    this.createdAt,
  });

  @override
  factory MasterPortfolioDto.fromJson(Map<String, dynamic> json) {
    try {
      return MasterPortfolioDto(
        id: json['id'] as int?,
        imageUrl: json['image_url'] as String?,
        description: json['description'] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'] as String)
            : null,
      );
    } catch (e) {
      log('Error parsing MasterPortfolioDto: $e');
      throw const FormatException('Invalid JSON format for MasterPortfolioDto');
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  MasterPortfolioDto copyWith({
    int? id,
    String? imageUrl,
    String? description,
    DateTime? createdAt,
  }) {
    return MasterPortfolioDto(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
