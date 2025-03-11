import 'dart:developer';
import 'dart:io';

import 'package:belle/src/core/core.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../../features/shared/shared.dart';

/// A class that holds intercepting logic for refreshing expired tokens. This
/// is the last interceptor in the queue.
class RefreshTokenInterceptor extends QueuedInterceptor {
  final Dio _dio;

  RefreshTokenInterceptor({
    required Dio dioClient,
  }) : _dio = dioClient;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final customException = CustomException.fromDioException(err);
    log('RefreshTokenInterceptor | onError triggered | Error: $customException');

    if (customException.exception is! TokenExpiredException) {
      log('err is! TokenExpiredException');
      return super.onError(err, handler);
    }
    try {
      log('trying to refresh token');
      // Get auth details for refresh token request
      final kVStorageService = KeyValueStorageService();
      final currentRefreshToken = await kVStorageService.getRefreshToken();

      if (currentRefreshToken.isEmpty) {
        return super.onError(err, handler);
      }

      final tokenDio = Dio()..options = _dio.options;

      tokenDio.options.headers.addAll({
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $currentRefreshToken',
      });

      tokenDio.interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));

      final newToken = await _refreshTokenRequest(
        dioError: err,
        tokenDio: tokenDio,
      );

      if (newToken == null) return super.onError(err, handler);

      // Update auth and unlock old dio
      await kVStorageService.setAuthToken(newToken.accessToken);
      await kVStorageService.setRefreshToken(newToken.refreshToken);

      // Make original req with new token
      final response = await _dio.request<Map<String, dynamic>>(
        err.requestOptions.path,
        data: err.requestOptions.data,
        cancelToken: err.requestOptions.cancelToken,
        options: Options(
          headers: <String, Object?>{
            HttpHeaders.authorizationHeader: 'Bearer $newToken',
          },
        ),
      );

      return handler.resolve(response);
    } catch (e) {
      return super.onError(err, handler);
    }
  }

  /// This method sends out a request to refresh the token. Since this request
  /// uses the new [Dio] instance it needs its own logging and error handling.
  ///
  /// ** The structure of response is dependant on the API and may not always
  /// be the same. It might need changing according to your own API. **
  Future<TokenDto?> _refreshTokenRequest({
    required DioException dioError,
    required Dio tokenDio,
  }) async {
    try {
      final response = await tokenDio.postData<ObjectResponse<TokenDto>>(
        ApiPathHelper.auth(AuthPath.tokenRefresh),
        converter: (json) => ObjectResponse.fromJson(json, TokenDto.fromJson),
      );

      log('\tResponse: $response');
      log('<-- END REFRESH');
      return response.data;
    } catch (ex) {
      // only caught here for logging
      // forward to try-catch in dio_service for handling
      log('\t--> ERROR');
      if (ex is DioException) {
        final de = ex;
        log('\t\t--> Exception: ${de.error}');
        log('\t\t--> Message: ${de.message}');
        log('\t\t--> Response: ${de.response}');
      } else {
        log('\t\t--> Exception: $ex');
      }
      log('\t<-- END ERROR');
      log('<-- END REFRESH');

      return null;
    }
  }
}
