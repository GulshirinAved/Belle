import 'package:belle/src/core/core.dart';
import 'package:belle/src/features/client/client.dart';
import 'package:dio/dio.dart';

import '../../../master.dart';

abstract class MasterPortfolioRepository {
  Future<ListResponse<MasterPortfolioDto>> fetchPortfolio(
      {PaginationParams? params});

  Future<ObjectResponse> addPortfolioImages(
      {required List<MultipartFile> photos});

  Future<ObjectResponse> deletePortfolioImage({required int? id});

  factory MasterPortfolioRepository(Dio client) =>
      _MasterPortfolioRepositoryImpl(client);
}

class _MasterPortfolioRepositoryImpl implements MasterPortfolioRepository {
  final Dio _client;

  const _MasterPortfolioRepositoryImpl(this._client);

  @override
  Future<ListResponse<MasterPortfolioDto>> fetchPortfolio(
      {PaginationParams? params}) async {
    final response = await _client.getData(
      MasterApiPathHelper.portfolio(MasterPortfolioPath.base),
      converter: (json) =>
          ListResponse.fromJson(json, MasterPortfolioDto.fromJson),
      requiresAuthToken: true,
      queryParameters: params?.toJson(),
    );
    return response;
  }

  @override
  Future<ObjectResponse> addPortfolioImages(
      {required List<MultipartFile> photos}) async {
    final response = await _client.postData(
      MasterApiPathHelper.portfolio(MasterPortfolioPath.base),
      converter: (json) => const ObjectResponse(),
      requiresAuthToken: true,
      data: FormData.fromMap({
        "photos": photos,
      }),
    );
    return response;
  }

  @override
  Future<ObjectResponse> deletePortfolioImage({required int? id}) async {
    final response = await _client.postData(
        MasterApiPathHelper.portfolio(MasterPortfolioPath.byId, id),
        converter: (json) => const ObjectResponse(),
        requiresAuthToken: true,
        queryParameters: {
          "portfolio_id": id,
        });
    return response;
  }
}
