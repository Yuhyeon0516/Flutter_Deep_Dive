import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_study/data/exceptions/app_exceptions.dart';
import 'package:bloc_study/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkServicesApi implements BaseApiService {
  @override
  Future<dynamic> deleteApi(String url) async {
    try {
      final res = await http
          .delete(
            Uri.parse(url),
          )
          .timeout(
            const Duration(seconds: 50),
          );

      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }
  }

  @override
  Future<dynamic> getApi(String url) async {
    try {
      final res = await http
          .get(
            Uri.parse(url),
          )
          .timeout(
            const Duration(seconds: 50),
          );

      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }
  }

  @override
  Future<dynamic> postApi(String url, data) async {
    try {
      final res = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(
            const Duration(seconds: 50),
          );

      return returnResponse(res);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic res = jsonDecode(response.body);
        return res;
      case 401:
        throw UnauthorisedException();
      case 500:
        throw FetchDataException();
    }
  }
}
