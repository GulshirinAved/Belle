import '../../../../../../../core/core.dart';

class MasterAddNewServiceDto extends Dto
    implements JsonSerializer<MasterAddNewServiceDto> {
  final int? idCSubservice;
  final int? minPrice;
  final int? maxPrice;
  final int? fixPrice;
  final int? time;
  final String? description;

  const MasterAddNewServiceDto({
    this.idCSubservice,
    this.minPrice,
    this.maxPrice,
    this.fixPrice,
    this.time,
    this.description,
  });

  @override
  factory MasterAddNewServiceDto.fromJson(Map<String, dynamic> json) {
    return MasterAddNewServiceDto(
      idCSubservice: json['id_c_subservice'] as int?,
      minPrice: json['min_price'] as int?,
      maxPrice: json['max_price'] as int?,
      fixPrice: json['fix_price'] as int?,
      time: json['time'] as int?,
      description: json['description'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id_c_subservice': idCSubservice,
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
      if (fixPrice != null) 'fix_price': fixPrice,
      'time': time,
      if (description != null) 'description': description,
    };
  }

  MasterAddNewServiceDto copyWith({
    int? idCSubservice,
    int? minPrice,
    int? maxPrice,
    int? fixPrice,
    int? time,
    String? description,
  }) {
    return MasterAddNewServiceDto(
      idCSubservice: idCSubservice ?? this.idCSubservice,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      fixPrice: fixPrice ?? this.fixPrice,
      time: time ?? this.time,
      description: description ?? this.description,
    );
  }
}
