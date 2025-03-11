import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../master.dart';

abstract class MasterPersonalInfoRepository {
  Future<ObjectResponse> updateData(MasterPersonalInfoDto data);

  Future<ObjectResponse> updateAccountPhoto(MultipartFile data);
  Future<ObjectResponse> deleteAccountPhoto();

  factory MasterPersonalInfoRepository(Dio client) =>
      _MasterPersonalInfoRepositoryImpl(client);
}

class _MasterPersonalInfoRepositoryImpl
    implements MasterPersonalInfoRepository {
  final Dio _client;

  const _MasterPersonalInfoRepositoryImpl(this._client);

  @override
  Future<ObjectResponse> updateAccountPhoto(MultipartFile data) async {
    final response = await _client.postData(
      MasterApiPathHelper.photo(MasterPhotoPath.base),
      converter: (_) => const ObjectResponse(),
      data: FormData.fromMap({
        "photo": data,
      }),
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse> updateData(MasterPersonalInfoDto data) async {
    final response = await _client.postData(
      MasterApiPathHelper.personalInfo(MasterPersonalInfoPath.edit),
      converter: (_) => const ObjectResponse(),
      data: data.toJson(),
      requiresAuthToken: true,
    );
    return response;
  }

  @override
  Future<ObjectResponse> deleteAccountPhoto() async {
    final response = await _client.postData(
      MasterApiPathHelper.photo(MasterPhotoPath.delete),
      converter: (_) => const ObjectResponse(),
      requiresAuthToken: true,
    );
    return response;
  }
}
