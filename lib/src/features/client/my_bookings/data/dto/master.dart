

import 'package:flutter/foundation.dart';

/// Модель Master
@immutable
class Master {
  final int? id;
  final String? personFn;
  final String? personLn;
  final String? phone;

  const Master({
    this.id,
    this.personFn,
    this.personLn,
    this.phone,
  });

  factory Master.fromJson(Map<String, dynamic> json) {
    return Master(
      id: json['id'] as int?,
      personFn: json['person_fn'] as String?,
      personLn: json['person_ln'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person_fn': personFn,
      'person_ln': personLn,
      'phone': phone,
    };
  }

  String get fullName => '${personFn ?? ''} ${personLn ?? ''}';
}
