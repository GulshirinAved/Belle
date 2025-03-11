part 'meta/meta_dto.dart';

abstract class ApiResponse<T> {
  final T? data;
  final String? message;
  final String? status;
  final String? errors;
  final int? statusCode;

  const ApiResponse({
    this.data,
    this.message,
    this.status,
    this.errors,
    this.statusCode,
  });
}

class ObjectResponse<T> extends ApiResponse<T> {
  const ObjectResponse({
    super.data,
    super.message,
    super.status,
    super.errors,
    super.statusCode,
  });

  factory ObjectResponse.fromJson(Map<String, dynamic> json,
      [T? Function(Map<String, dynamic>)? fromJsonT]) {
    return ObjectResponse(
      data: fromJsonT?.call(json['data'] ?? {}),
      message: json['message'],
      status: json['status'],
      errors: json['errors'],
      statusCode: json['status_code'],
    );
  }
}

class ListResponse<T> extends ApiResponse<List<T>> {
  const ListResponse({
    super.data,
    super.message,
    super.status,
    super.errors,
    super.statusCode,
  });

  factory ListResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ListResponse(
      data: (json['data'] as List).map((e) {
        if (e is Map<String, dynamic>) {
          return fromJsonT(e);
        } else {
          throw Exception('Invalid item type in data list');
        }
      }).toList(),
      message: json['message'],
      status: json['status'],
      errors: json['errors'],
      statusCode: json['statusCode'],
    );
  }
}

class ApiErrorModel {
  final String errorCode;
  final String message;
  final String? clientAction;
  final int statusCode;

  ApiErrorModel({
    required this.errorCode,
    required this.message,
    this.clientAction,
    required this.statusCode,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      errorCode: json['error_code'] ?? 'unknown_error',
      message: json['message'] ?? 'An unknown error occurred',
      clientAction: json['client_action'],
      statusCode: json['status_code'] ?? 500,
    );
  }

  bool get requiresLogout => clientAction == 'logout';
  bool get requiresRefresh => clientAction == 'refresh';
}
