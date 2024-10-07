import 'package:full_course/core/secrets/app_secrets.dart';
import 'package:full_course/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:full_course/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:full_course/features/auth/domain/repository/auth_repository.dart';
import 'package:full_course/features/auth/domain/usecases/user_sign_up.dart';
import 'package:full_course/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);
}

void _initAuth() {
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      sl<SupabaseClient>(),
    ),
  );

  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
    ),
  );

  sl.registerFactory<UserSignUp>(
    () => UserSignUp(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUp: sl<UserSignUp>(),
    ),
  );
}
