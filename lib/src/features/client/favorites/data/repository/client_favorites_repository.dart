import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';

import '../../../client.dart';

const _masterIdKey = 'id_master';

abstract class ClientFavoritesRepository {
  Future<ListResponse<ClientMasterDto>> fetchFavorites(
      {int? size, int? number});

  Future<ObjectResponse> addOrRemoveFavorite(int? masterId);

  Future<ObjectResponse> deleteAll();

  factory ClientFavoritesRepository(Dio client) =>
      _ClientFavoritesRepositoryImpl(client);
}

class _ClientFavoritesRepositoryImpl implements ClientFavoritesRepository {
  final Dio _client;

  const _ClientFavoritesRepositoryImpl(this._client);

  @override
  Future<ListResponse<ClientMasterDto>> fetchFavorites(
      {int? size = 10, int? number = 1}) async {
    final response = await _client.getData<ListResponse<ClientMasterDto>>(
      ApiPathHelper.favorites(FavoritesPath.base),
      converter: (json) =>
          ListResponse.fromJson(json, ClientMasterDto.fromJson),
      queryParameters: {
        "page": number,
        "per_page": size,
      },
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse> addOrRemoveFavorite(int? masterId) async {
    final response = await _client.postData<ObjectResponse>(
      ApiPathHelper.favorites(FavoritesPath.base),
      converter: (json) {
        return ObjectResponse.fromJson(json);
      },
      data: {_masterIdKey: masterId},
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse> deleteAll() async {
    final response = await _client.postData<ObjectResponse>(
      ApiPathHelper.favorites(FavoritesPath.delete),
      converter: (_) {
        return const ObjectResponse();
      },
      requiresAuthToken: true,
    );
    return response;
  }
}
