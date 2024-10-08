import 'package:fpdart/fpdart.dart';
import 'package:full_course/core/error/failure.dart';
import 'package:full_course/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> currentUser();
}
