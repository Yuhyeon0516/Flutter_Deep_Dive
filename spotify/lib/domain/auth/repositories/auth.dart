import 'package:dartz/dartz.dart';
import 'package:spotify/data/auth/models/create_user_req.dart';
import 'package:spotify/data/auth/models/signin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
}
