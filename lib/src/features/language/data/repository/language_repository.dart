// import 'package:biar_admin/src/core/network/network.dart';
// import 'package:dio/dio.dart';
//
// abstract class LanguageRepository {
//   Future<MetaWithDataResponse> setLocale(String locale);
//
//   factory LanguageRepository(Dio client) => _LanguageRepositoryImpl(client);
// }
//
// class _LanguageRepositoryImpl implements LanguageRepository {
//   final Dio _client;
//
//   const _LanguageRepositoryImpl(this._client);
//
//   @override
//   Future<MetaWithDataResponse> setLocale(String locale) async {
//     final response = await _client.postData<MetaWithDataResponse>(
//       ApiPathHelper.locale(LocalePath.base),
//       requiresAuthToken: true,
//       data: {
//         "admin_locale": locale,
//       },
//       converter: (json) => MetaWithDataResponse.fromJson(
//         json['meta'],
//         (value) => null,
//       ),
//     );
//     return response;
//   }
// }
