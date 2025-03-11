import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';

import '../../../client.dart';

abstract class ClientMasterInfoRepository {
  Future<ObjectResponse<ClientMasterInfoDto>> fetchMasterInfo({int? id});
  Future<ListResponse<ClientMasterReviewDto>> fetchMasterReviews({required ClientMasterReviewsParams params});

  factory ClientMasterInfoRepository(Dio client) =>
      _ClientMasterInfoRepositoryImpl(client);
}

class _ClientMasterInfoRepositoryImpl implements ClientMasterInfoRepository {
  final Dio _client;

  const _ClientMasterInfoRepositoryImpl(this._client);

  @override
  Future<ObjectResponse<ClientMasterInfoDto>> fetchMasterInfo({int? id}) async {
    final response = await _client.getData(
      ApiPathHelper.master(MasterPath.base, id),
      converter: (json) =>
          ObjectResponse.fromJson(json, ClientMasterInfoDto.fromJson),
    );
    return response;
  }

  @override
  Future<ListResponse<ClientMasterReviewDto>> fetchMasterReviews({required ClientMasterReviewsParams params}) async {
    final response = await _client.getData<ListResponse<ClientMasterReviewDto>>(
      ApiPathHelper.master(MasterPath.reviews, params.masterId),
      queryParameters: params.toJson(),
      converter: (json) =>
          ListResponse.fromJson(json, ClientMasterReviewDto.fromJson),
    );
    return response;
  }


}
