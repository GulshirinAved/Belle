part of '../models.dart';

class Meta {
  final String? requestId;
  final String? timestamp;

  const Meta({this.requestId, this.timestamp});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      requestId: json['request_id'],
      timestamp: json['timestamp'],
    );
  }
}
