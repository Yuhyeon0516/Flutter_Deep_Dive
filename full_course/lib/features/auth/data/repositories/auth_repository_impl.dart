import 'package:fpdart/fpdart.dart';
import 'package:full_course/core/error/exception.dart';
import 'package:full_course/core/error/failure.dart';
import 'package:full_course/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:full_course/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmailPaswword(
        name: name,
        email: email,
        password: password,
      );

      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.meesage));
    }
  }
}
