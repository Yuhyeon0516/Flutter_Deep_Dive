import 'package:fpdart/fpdart.dart';
import 'package:full_course/core/error/exception.dart';
import 'package:full_course/core/error/failure.dart';
import 'package:full_course/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:full_course/features/auth/domain/entities/user.dart';
import 'package:full_course/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentuserData();

      if (user == null) {
        return left(Failure('로그인에 안되어있습니다.'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.meesage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPaswword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPaswword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
      Future<UserEntity> Function() fn) async {
    try {
      final user = await fn();

      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.meesage));
    }
  }
}
