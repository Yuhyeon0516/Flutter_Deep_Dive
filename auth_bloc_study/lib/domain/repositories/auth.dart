import 'package:auth_bloc_study/data/models/signup_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams signupReq);
}
