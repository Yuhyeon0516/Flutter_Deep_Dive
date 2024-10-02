import 'package:auth_bloc_study/core/usecase/usecase.dart';
import 'package:auth_bloc_study/data/models/signup_req_params.dart';
import 'package:auth_bloc_study/domain/repositories/auth.dart';
import 'package:auth_bloc_study/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase implements Usecase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthRepository>().signup(param!);
  }
}
