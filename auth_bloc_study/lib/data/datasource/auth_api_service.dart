import 'package:auth_bloc_study/core/constants/api_urls.dart';
import 'package:auth_bloc_study/core/network/dio_client.dart';
import 'package:auth_bloc_study/data/models/signup_req_params.dart';
import 'package:auth_bloc_study/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      // final res = await sl<DioClient>().post(
      //   ApiUrls.baseUrl,
      //   data: signupReq.toMap(),
      // );

      return const Right('a');
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
