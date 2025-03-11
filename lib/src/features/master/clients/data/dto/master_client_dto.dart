import 'package:belle/src/core/core.dart';

class MasterClientDto extends Dto implements JsonSerializer<MasterClientDto> {
  final String? contactName;
  final String? contactPhone;
  final int? id;
  final int? contactAddingType;

  const MasterClientDto({
    this.contactName,
    this.contactPhone,
    this.id,
    this.contactAddingType,
  });

  @override
  factory MasterClientDto.fromJson(Map<String, dynamic> json) {
    return MasterClientDto(
      contactName: json['contact_name'] as String?,
      contactPhone: json['contact_phone'] as String?,
      id: json['id'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (contactName != null) 'contact_name': contactName,
      if (contactPhone != null) 'contact_phone': contactPhone,
      if (id != null) 'id': id,
      if (contactAddingType != null) 'contact_adding_type': contactAddingType,
    };
  }

  MasterClientDto copyWith({
    String? contactName,
    String? contactPhone,
    int? id,
  }) {
    return MasterClientDto(
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
      id: id ?? this.id,
    );
  }
}

class MasterEditClientDto extends Dto
    implements JsonSerializer<MasterClientDto> {
  final String? contactName;
  final String? contactPhone;
  final String? contactOldPhone;
  final String? contactOldName;

  const MasterEditClientDto({
    this.contactName,
    this.contactPhone,
    this.contactOldPhone,
    this.contactOldName,
  });

  @override
  factory MasterEditClientDto.fromJson(Map<String, dynamic> json) {
    return MasterEditClientDto(
      contactName: json['contact_name'] as String?,
      contactPhone: json['contact_phone'] as String?,
      // id: json['id'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      if (contactName != null) 'contacts_new_name': contactName,
      if (contactPhone != null) 'contacts_new_phone': contactPhone,
      if (contactOldPhone != null) 'contacts_old_phone': contactOldPhone,
      if (contactOldName != null) 'contacts_old_name': contactOldName,
    };
  }

  MasterClientDto copyWith({
    String? contactName,
    String? contactPhone,
    int? id,
  }) {
    return MasterClientDto(
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
    );
  }
}
