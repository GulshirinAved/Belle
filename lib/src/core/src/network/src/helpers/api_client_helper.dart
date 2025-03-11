
import 'package:belle/src/core/core.dart';
import 'package:belle/src/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension DioExtension on Dio {
  /// Fetching data object
  Future<T> getData<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) converter,
    bool requiresAuthToken = false,
  }) async {
    try {
      final response = await get(
        path,
        queryParameters: queryParameters,
        options: Options(
          extra: {AppConstants.requiresAuthToken: requiresAuthToken},
        ),
      );
      return converter(response.data);
    } on DioException catch (e) {
      final customException = CustomException.fromDioException(e);

      if (customException.exception is TokenRevokedException ||
          customException.exception is UnauthorizedException) {
        throw customException.exception;
      }
      throw handleError(e);
    } catch (e) {
      throw handleError(e);
    }
  }

  /// Posting data
  Future<T> postData<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) converter,
    bool requiresAuthToken = false,
  }) async {
    try {
      final response = await post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          extra: {
            AppConstants.requiresAuthToken: requiresAuthToken,
          },
        ),
      );
      return converter(response.data);
    } on DioException catch (e) {
      final customException = CustomException.fromDioException(e);

      if (customException.exception is TokenRevokedException ||
          customException.exception is UnauthorizedException) {
        throw customException.exception;
      }
      throw handleError(e);
    } catch (e) {
      throw handleError(e);
    }
  }

  /// Patching data
  Future<T> patchData<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) converter,
    bool requiresAuthToken = false,
  }) async {
    try {
      final response = await patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          extra: {AppConstants.requiresAuthToken: requiresAuthToken},
        ),
      );
      return converter(response.data);
    } on DioException catch (e) {
      final customException = CustomException.fromDioException(e);

      if (customException.exception is TokenRevokedException ||
          customException.exception is UnauthorizedException) {
        throw customException.exception;
      }
      throw handleError(e);
    } catch (e) {
      throw handleError(e);
    }
  }

  /// Deleting data
  Future<T> deleteData<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) converter,
    bool requiresAuthToken = false,
  }) async {
    try {
      final response = await delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          extra: {AppConstants.requiresAuthToken: requiresAuthToken},
        ),
      );
      return converter(response.data);
    } on DioException catch (e) {
      final customException = CustomException.fromDioException(e);

      if (customException.exception is TokenRevokedException ||
          customException.exception is UnauthorizedException) {
        throw customException.exception;
      }
      throw handleError(e);
    } catch (e) {
      throw handleError(e);
    }
  }

  /// Centralized error handler for Dio errors
  String handleError(dynamic e) {
    if (e is DioException) {
      return _handleErrorMessage(e);
    } else if (e is TypeError) {
      debugPrint(e.toString());
      return 'Failed to convert data: $e';
    } else if (e is FormatException) {
      debugPrint(e.toString());
      return 'Format exception: $e';
    } else {
      debugPrint(e.toString());
      return 'An error occurred: $e';
    }
  }

  ApiErrorModel _formatException(dynamic data) {
    return ApiErrorModel.fromJson(data);
  }

  /// Formats Dio exceptions to provide detailed information
  String _handleErrorMessage(DioException e) {
    final status =
        'Status: ${e.response?.statusCode} ${e.response?.statusMessage}\n${e.type}';
    try {
      final formattedException = _formatException(e.response?.data);
      return formattedException.message;
    } catch (e) {
      return status;
    }
  }
}
