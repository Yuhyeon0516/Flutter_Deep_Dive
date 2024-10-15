import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_study/network_manager/rest_client.dart';

final restClient = RestClient(dio, baseUrl: '');

final dio = getDio();

Dio getDio() {
  BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    contentType: 'application/json',
    sendTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  Dio dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      debugPrint('API Request Body: ${options.data}');

      return handler.next(options);
    },
    onResponse: (response, handler) {
      debugPrint('API Response: ${response.data}');

      return handler.next(response);
    },
    onError: (error, handler) {
      final res = error.response;

      debugPrint(
          'API Error -> Status Code: ${res?.statusCode} -> ${res?.statusMessage}: Error -> ${error.toString()}');

      return handler.next(error);
    },
  ));

  return dio;
}
