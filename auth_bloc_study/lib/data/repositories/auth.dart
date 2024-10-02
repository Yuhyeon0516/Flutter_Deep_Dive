import 'package:auth_bloc_study/data/datasource/auth_api_service.dart';
import 'package:auth_bloc_study/data/models/signup_req_params.dart';
import 'package:auth_bloc_study/domain/repositories/auth.dart';
import 'package:auth_bloc_study/service_locator.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    return sl<AuthApiService>().signup(signupReq);
  }
}
