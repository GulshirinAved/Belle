import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network.dart';

class Configs {
  static const protocol = 'http://';
  static const externalHost = '95.85.109.86'; // Внешний хост
  static const internalHost = '172.17.0.27'; // Внутренний хост (imdatHost)
  static const port = '81';
  static const api = 'app/';

  static String getHost(String selectedHost) {
    // if (selectedHost == 'internal') {
    //   return internalHost;
    // } else {
    return externalHost;
    // }
  }

  static String getBaseUrl(String selectedHost) {
    final host = getHost(selectedHost);
    return '$protocol$host:$port/$api';
  }
}

class AppHttpClient {
  const AppHttpClient._();

  static Dio configureClient(String selectedHost) {
    log('SelectedHost:$selectedHost');
    final client = Dio(
      // 'internal'
      BaseOptions(
        baseUrl: Configs.getBaseUrl(selectedHost),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      ),
    );

    client.interceptors.add(ApiInterceptor());
    // client.interceptors.add(ErrorInterceptors(client));
    client.interceptors.add(RefreshTokenInterceptor(dioClient: client));
    // // Log all requests and responses
    client.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (object) => log(object.toString()),
    ));
    return client;
  }
}
