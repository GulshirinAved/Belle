import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/shared/shared.dart';
import 'package:dio/dio.dart';

abstract class ReferencesRepository {
  Future<ObjectResponse<ReferencesDto>> fetchReferences({int? cityId});

  factory ReferencesRepository(Dio client) => _ReferencesRepositoryImpl(client);
}

class _ReferencesRepositoryImpl implements ReferencesRepository {
  final Dio _client;

  const _ReferencesRepositoryImpl(this._client);

  @override
  Future<ObjectResponse<ReferencesDto>> fetchReferences({int? cityId}) async {
    final response = await _client.getData<ObjectResponse<ReferencesDto>>(
      ApiPathHelper.references(ReferencesPath.base),
      queryParameters: {
        if (cityId != null) "id_c_city": cityId,
      },
      converter: (json) =>
          ObjectResponse.fromJson(json, ReferencesDto.fromJson),
    );
    return response;
  }
}
