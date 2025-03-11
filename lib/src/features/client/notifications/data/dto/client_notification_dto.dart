
import 'package:flutter/foundation.dart';

/// Модель ClientNotificationDto
@immutable
class ClientNotificationDto {
  final int? id;
  final String? title;
  final int? type;
  final String? message;
  final String? createdAt;
  final String? readAt;
  final bool? isRead;

  const ClientNotificationDto({
    this.id,
    this.title,
    this.type,
    this.message,
    this.createdAt,
    this.readAt,
    this.isRead,
  });

  factory ClientNotificationDto.fromJson(Map<String, dynamic> json) {
    return ClientNotificationDto(
      id: json['id'] as int?,
      title: json['title'] as String?,
      type: json['type'] as int?,
      message: json['message'] as String?,
      createdAt: json['created_at'] as String?,
      readAt: json['read_at'] as String?,
      isRead: json['is_read'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'message': message,
      'created_at': createdAt,
      'read_at': readAt,
      'is_read': isRead,
    };
  }
}
