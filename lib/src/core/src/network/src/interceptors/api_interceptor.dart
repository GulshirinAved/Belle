import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../utils/utils.dart';
import '../../../local/src/key_value_storage_service.dart';

/// A class that holds intercepting logic for API related requests. This is
/// the first interceptor in case of both request and response.
///
/// Primary purpose is to handle token injection and response success validation
///
/// Since this interceptor isn't responsible for error handling, if an exception
/// occurs it is passed on the next [Interceptor] or to [Dio].
class ApiInterceptor extends Interceptor {
  ApiInterceptor() : super();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('ApiInterceptor | onRequest triggered');

    if (options.extra.containsKey(AppConstants.requiresAuthToken)) {
      if (options.extra[AppConstants.requiresAuthToken] == true) {
        final token = await KeyValueStorageService().getAuthToken();
        // const staticToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTczNzU1MDA1OSwianRpIjoiZGUxNThjM2YtMGRkZS00YjZiLTg4OWYtZDQ3NzE0YjA1MDExIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6NCwibmJmIjoxNzM3NTUwMDU5LCJjc3JmIjoiMWExZWFiMzUtNWM1Ni00YzEyLWFhNTUtZmVkNWY2ZjdlZTdjIiwiZXhwIjoxNzM4ODQ2MDU5fQ.WBUWwCZULAVHpxH4TQkiQEHcnOJYcnv7UEESS9E4CcU';
        log('Auth - Token from storage: $token');
        if (token.isNotEmpty) {
          options.headers.addAll(
            <String, Object?>{HttpHeaders.authorizationHeader: 'Bearer $token'},
          );
        }
        options.extra.remove(AppConstants.requiresAuthToken);
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    log('ApiInterceptor | onResponse triggered');
    return handler.next(response);
  }
}
