import 'package:auth_bloc_study/core/network/dio_client.dart';
import 'package:auth_bloc_study/data/datasource/auth_api_service.dart';
import 'package:auth_bloc_study/data/repositories/auth.dart';
import 'package:auth_bloc_study/domain/repositories/auth.dart';
import 'package:auth_bloc_study/domain/usecases/signup.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // service
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  // repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // usecase
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
}
