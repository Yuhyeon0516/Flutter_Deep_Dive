import 'package:fpdart/fpdart.dart';
import 'package:full_course/core/error/failure.dart';
import 'package:full_course/core/usecase/usecase.dart';
import 'package:full_course/core/common/entities/user.dart';
import 'package:full_course/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
