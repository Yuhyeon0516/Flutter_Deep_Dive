import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_bloc_retrofit/network_manager/rest_client.dart';

final client = RestClient(dio, baseUrl: 'https://api.nstack.in');

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
      log('Request Body: ${jsonEncode(options.data)}');

      return handler.next(options);
    },
    onResponse: (response, handler) {
      log('Response: ${jsonEncode(response.data)}');

      return handler.next(response);
    },
    onError: (error, handler) {
      final res = error.response;

      log('Error: ${jsonEncode(error.toString())} || Status Code: ${res?.statusCode}');

      if (res?.statusCode == 401) {}

      return handler.next(error);
    },
  ));

  return dio;
}
