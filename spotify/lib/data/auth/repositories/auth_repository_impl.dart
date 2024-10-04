import 'package:dartz/dartz.dart';
import 'package:spotify/data/auth/datasource/auth_firebase_service.dart';
import 'package:spotify/data/auth/models/create_user_req.dart';
import 'package:spotify/data/auth/models/signin_user_req.dart';
import 'package:spotify/domain/auth/repositories/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }
}
