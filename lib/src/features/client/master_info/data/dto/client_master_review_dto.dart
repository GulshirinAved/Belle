import 'package:flutter/foundation.dart';

@immutable
class ClientMasterReviewDto {
  final Client? client;
  final String? date;
  final int? id;
  final MasterReply? masterReply;
  final int? rating;
  final Service? service;
  final String? text;
  final String? time;

  const ClientMasterReviewDto({
    this.client,
    this.date,
    this.id,
    this.masterReply,
    this.rating,
    this.service,
    this.text,
    this.time,
  });

  factory ClientMasterReviewDto.fromJson(Map<String, dynamic> json) {
    return ClientMasterReviewDto(
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      date: json['date'] as String?,
      id: json['id'] as int?,
      masterReply: json['master_reply'] != null
          ? MasterReply.fromJson(json['master_reply'])
          : null,
      rating: json['rating'] as int?,
      service:
          json['service'] != null ? Service.fromJson(json['service']) : null,
      text: json['text'] as String?,
      time: json['time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client': client?.toJson(),
      'date': date,
      'id': id,
      'master_reply': masterReply?.toJson(),
      'rating': rating,
      'service': service?.toJson(),
      'text': text,
      'time': time,
    };
  }
}

/// Модель Client
@immutable
class Client {
  final int? id;
  final String? name;

  const Client({
    this.id,
    this.name,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

/// Модель MasterReply
@immutable
class MasterReply {
  final int? idMasterOverview;
  final String? replyCreatedAt;
  final int? replyId;
  final String? replyText;

  const MasterReply({
    this.idMasterOverview,
    this.replyCreatedAt,
    this.replyId,
    this.replyText,
  });

  factory MasterReply.fromJson(Map<String, dynamic> json) {
    return MasterReply(
      idMasterOverview: json['id_master_overview'] as int?,
      replyCreatedAt: json['reply_created_at'] as String?,
      replyId: json['reply_id'] as int?,
      replyText: json['reply_text'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_master_overview': idMasterOverview,
      'reply_created_at': replyCreatedAt,
      'reply_id': replyId,
      'reply_text': replyText,
    };
  }
}

/// Модель Service
@immutable
class Service {
  final int? id;
  final String? name;
  final String? subservice;

  const Service({
    this.id,
    this.name,
    this.subservice,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as int?,
      name: json['name'] as String?,
      subservice: json['subservice'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subservice': subservice,
    };
  }
}
