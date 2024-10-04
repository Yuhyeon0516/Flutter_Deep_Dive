import 'package:get_it/get_it.dart';
import 'package:spotify/data/auth/datasource/auth_firebase_service.dart';
import 'package:spotify/data/auth/repositories/auth_repository_impl.dart';
import 'package:spotify/domain/auth/repositories/auth.dart';
import 'package:spotify/domain/auth/usecases/signin.dart';
import 'package:spotify/domain/auth/usecases/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
}
