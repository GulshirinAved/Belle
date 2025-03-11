import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class ReceiveTimeoutException extends DioException {
  ReceiveTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class ConnectTimeoutException extends DioException {
  ConnectTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class CancelException extends DioException {
  CancelException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class SendTimeoutException extends DioException {
  SendTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class BadCertificateException extends DioException {
  BadCertificateException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Bad certificate';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class TimeOutException extends DioException {
  TimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

/// Exception for Refresh token logic
class TokenExpiredException extends DioException {
  TokenExpiredException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Token has expired and needs to be refreshed';
  }
}

/// Exception for Logout logic
class TokenRevokedException extends DioException {
  TokenRevokedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Token has been revoked, user needs to log in again';
  }
}

class CustomException implements Exception {
  final String name, message;
  final String? code;
  final int? statusCode;
  final Exception exception;
  final ApiErrorModel? apiErrorModel;

  CustomException({
    this.code,
    int? statusCode,
    required this.message,
    required this.exception,
    this.apiErrorModel,
  })  : statusCode = statusCode ?? 500,
        name = exception.runtimeType.toString();

  factory CustomException.fromDioException(Exception error) {
    try {
      if (error is DioException) {
        // Try to parse ApiErrorModel from response data first
        ApiErrorModel? apiErrorModel;
        if (error.response?.data != null) {
          try {
            apiErrorModel = ApiErrorModel.fromJson(error.response?.data);
          } catch (e) {
            // If parsing fails, log the error and continue without ApiErrorModel
            log('Error parsing ApiErrorModel: $e');
          }
        }

        // If ApiErrorModel was parsed, use its data, otherwise use default messages
        if (apiErrorModel != null) {
          if (apiErrorModel.requiresLogout) {
            return CustomException(
              exception: TokenRevokedException(error.requestOptions),
              code: apiErrorModel.errorCode,
              statusCode: apiErrorModel.statusCode,
              message: apiErrorModel.message,
              apiErrorModel: apiErrorModel,
            );
          }
          if (apiErrorModel.requiresRefresh) {
            return CustomException(
              exception: TokenExpiredException(error.requestOptions),
              code: apiErrorModel.errorCode,
              statusCode: apiErrorModel.statusCode,
              message: apiErrorModel.message,
              apiErrorModel: apiErrorModel,
            );
          }
          // If no special action, return a generic CustomException with ApiErrorModel
          return CustomException(
            exception: Exception(apiErrorModel.message),
            code: apiErrorModel.errorCode,
            statusCode: apiErrorModel.statusCode,
            message: apiErrorModel.message,
            apiErrorModel: apiErrorModel,
          );
        }

        // Handle DioErrorTypes without ApiErrorModel
        switch (error.type) {
          case DioExceptionType.cancel:
            return CustomException(
              exception: CancelException(error.requestOptions),
              statusCode: error.response?.statusCode,
              message: 'Request cancelled prematurely',
            );
          case DioExceptionType.connectionTimeout:
            return CustomException(
              exception: ConnectTimeoutException(error.requestOptions),
              statusCode: error.response?.statusCode,
              message: 'Connection not established',
            );
          case DioExceptionType.sendTimeout:
            return CustomException(
              exception: SendTimeoutException(error.requestOptions),
              statusCode: error.response?.statusCode,
              message: 'Failed to send',
            );
          case DioExceptionType.receiveTimeout:
            return CustomException(
              exception: ReceiveTimeoutException(error.requestOptions),
              statusCode: error.response?.statusCode,
              message: 'Failed to receive',
            );
          case DioExceptionType.connectionError:
            return CustomException(
              exception: NoInternetConnectionException(error.requestOptions),
              statusCode: error.response?.statusCode,
              message: 'No internet connectivity',
            );
          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 400:
                return CustomException(
                  exception: BadRequestException(error.requestOptions),
                  statusCode: error.response?.statusCode,
                  message: 'Invalid request',
                );
              case 401:
                return CustomException(
                  exception: UnauthorizedException(error.requestOptions),
                  statusCode: error.response?.statusCode,
                  message: 'Access denied',
                );
              case 404:
                return CustomException(
                  exception: NotFoundException(error.requestOptions),
                  statusCode: error.response?.statusCode,
                  message: 'The requested information could not be found',
                );
              case 409:
                return CustomException(
                  exception: ConflictException(error.requestOptions),
                  statusCode: error.response?.statusCode,
                  message: 'Conflict occurred',
                );
              case 500:
                return CustomException(
                  exception: InternalServerErrorException(error.requestOptions),
                  statusCode: error.response?.statusCode,
                  message: 'Unknown error occurred, please try again later.',
                );
              default:
                return CustomException(
                  exception: Exception('An unknown error occurred'),
                  statusCode: error.response?.statusCode,
                  message: error.response?.statusMessage ?? 'Unknown',
                );
            }
          case DioExceptionType.unknown:
            return CustomException(
              exception: Exception('An unknown error occurred'),
              message: 'Error unrecognized',
            );
          case DioExceptionType.badCertificate:
            return CustomException(
              exception: BadCertificateException(error.requestOptions),
              message: 'Bad certificate',
            );
        }
      } else {
        return CustomException(
          exception: Exception('Error unrecognized'),
          message: 'Error unrecognized',
        );
      }
    } on FormatException catch (e) {
      return CustomException(
        exception: e,
        message: e.message,
      );
    } on Exception catch (e) {
      return CustomException(
        exception: e,
        message: 'Error unrecognized',
      );
    }
  }
}
