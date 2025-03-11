import 'package:belle/src/features/client/client.dart';
import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../master.dart';

abstract class MasterClientsRepository {
  Future<ListResponse<MasterClientDto>> fetchClients(
      {PaginationParams? params});

  Future<ObjectResponse<void>> addNewClient({required MasterClientDto data});
  Future<ObjectResponse<void>> deleteClient({required MasterClientDto data});
  Future<ObjectResponse<void>> editClient({required MasterEditClientDto data});

  factory MasterClientsRepository(Dio client) =>
      _MasterClientsRepositoryImpl(client);
}

class _MasterClientsRepositoryImpl implements MasterClientsRepository {
  final Dio _client;

  const _MasterClientsRepositoryImpl(this._client);

  @override
  Future<ListResponse<MasterClientDto>> fetchClients(
      {PaginationParams? params}) async {
    final response = await _client.getData(
      MasterApiPathHelper.contacts(MasterContactsPath.base),
      converter: (json) =>
          ListResponse.fromJson(json, MasterClientDto.fromJson),
      requiresAuthToken: true,
      queryParameters: params?.toJson(),
    );
    return response;
  }

  @override
  Future<ObjectResponse<void>> addNewClient(
      {required MasterClientDto data}) async {
    final response = await _client.postData(
      MasterApiPathHelper.contacts(MasterContactsPath.create),
      converter: (_) => const ObjectResponse(),
      requiresAuthToken: true,
      data: {
        "contacts": [
          data.toJson(),
        ]
      },
    );
    return response;
  }

  @override
  Future<ObjectResponse<void>> deleteClient(
      {required MasterClientDto data}) async {
    final response = await _client.postData(
      MasterApiPathHelper.contacts(MasterContactsPath.delete),
      converter: (_) => const ObjectResponse(),
      requiresAuthToken: true,
      data: data.toJson(),
    );
    return response;
  }

  @override
  Future<ObjectResponse<void>> editClient(
      {required MasterEditClientDto data}) async {
    final response = await _client.postData(
      MasterApiPathHelper.contacts(MasterContactsPath.edit),
      converter: (_) => const ObjectResponse(),
      requiresAuthToken: true,
      data: data.toJson(),
    );
    return response;
  }
}
