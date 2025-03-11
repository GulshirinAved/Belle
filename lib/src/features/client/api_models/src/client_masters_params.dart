import 'package:flutter/foundation.dart';

const genderId = 'gender_id';

@immutable
class ClientMastersParams {
  final int? size;
  final int? number;
  final int? masterTypeId;
  final int? serviceId;
  final int? profileId;
  final String? query;
  final ClientMasterRanking? ranking;
  final ClientMastersSortParams? sortParams;

  const ClientMastersParams({
    this.size,
    this.number,
    required this.masterTypeId,
    this.serviceId,
    this.ranking,
    this.profileId,
    this.query,
    this.sortParams,
  });

  Map<String, dynamic> toJson() {
    return {
      'gender_id': masterTypeId,
      if (ranking != null) "parameter": ranking?.parseName,
      if (number != null) "page": number,
      if (size != null) "per_page": size,
      if (profileId != null) "profile_id": profileId,
      if (query != null && (query?.isNotEmpty ?? false)) "query": query,
      if (sortParams != null) ...sortParams?.toJson() ?? {},
    };
  }

  ClientMastersParams copyWith({
    int? size,
    int? number,
    int? masterTypeId,
    int? serviceId,
    int? profileId,
    String? query,
    ClientMasterRanking? ranking,
    ClientMastersSortParams? sortParams,
  }) {
    return ClientMastersParams(
      size: size ?? this.size,
      number: number ?? this.number,
      masterTypeId: masterTypeId ?? this.masterTypeId,
      serviceId: serviceId ?? this.serviceId,
      profileId: profileId ?? this.profileId,
      query: query ?? this.query,
      ranking: ranking ?? this.ranking,
      sortParams: sortParams ?? this.sortParams,
    );
  }
}

enum ClientMasterRanking {
  newMasters,
  ranking;

  String get parseName {
    switch (this) {
      case ClientMasterRanking.newMasters:
        return 'new';
      case ClientMasterRanking.ranking:
        return 'ranking';
    }
  }
}

@immutable
class ClientMastersSortParams {
  final ClientMastersOrderBy orderBy;
  final ClientMastersSortBy sortBy;

  const ClientMastersSortParams(this.orderBy, this.sortBy);

  Map<String, dynamic> toJson() {
    return {
      'order_by': orderBy.name,
      'sort_by': sortBy.name,
    };
  }

  ClientMastersSortParams copyWith({
    ClientMastersOrderBy? orderBy,
    ClientMastersSortBy? sortBy,
  }) {
    return ClientMastersSortParams(
      orderBy ?? this.orderBy,
      sortBy ?? this.sortBy,
    );
  }
}

enum ClientMastersOrderBy {
  asc,
  desc,
}

enum ClientMastersSortBy {
  rating,
}