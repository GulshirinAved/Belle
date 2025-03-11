import 'package:belle/src/core/core.dart';

import '../../../master.dart';

class MasterEditServiceDto extends Dto
    implements JsonSerializer<MasterEditServiceDto> {
  final int? idCSubservice;
  final int? idMasterService;
  final int? minPrice;
  final int? maxPrice;
  final int? fixPrice;
  final int? time;
  final String? description;

  const MasterEditServiceDto({
    this.idCSubservice,
    this.minPrice,
    this.maxPrice,
    this.fixPrice,
    this.time,
    this.description,
    this.idMasterService,
  });

  @override
  factory MasterEditServiceDto.fromJson(Map<String, dynamic> json) {
    return MasterEditServiceDto(
      idMasterService: json['id_master_service'] as int?,
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
      'id_master_service': idMasterService,
      'id_c_subservice': idCSubservice,
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
      if (fixPrice != null) 'fix_price': fixPrice,
      'time': time,
      if (description != null && (description?.isNotEmpty ?? false))
        'description': description,
    };
  }

  MasterEditServiceDto copyWith({
    int? minPrice,
    int? maxPrice,
    int? fixPrice,
    int? time,
    String? description,
  }) {
    return MasterEditServiceDto(
      idCSubservice: idCSubservice,
      idMasterService: idMasterService,
      minPrice: minPrice,
      maxPrice: maxPrice,
      fixPrice: fixPrice,
      time: time ?? this.time,
      description: description ?? this.description,
    );
  }

  static MasterEditServiceDto fromMasterServiceDto(MasterServiceDto dto) {
    return MasterEditServiceDto(
      idMasterService: dto.id,
      idCSubservice: dto.subserviceId,
      minPrice: dto.minPrice,
      maxPrice: dto.maxPrice,
      fixPrice: dto.fixPrice,
      time: dto.time,
      description: dto.description,
    );
  }
}
