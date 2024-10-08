import 'package:full_course/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:full_course/core/secrets/app_secrets.dart';
import 'package:full_course/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:full_course/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:full_course/features/auth/domain/repository/auth_repository.dart';
import 'package:full_course/features/auth/domain/usecases/current_user.dart';
import 'package:full_course/features/auth/domain/usecases/user_login.dart';
import 'package:full_course/features/auth/domain/usecases/user_sign_up.dart';
import 'package:full_course/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:full_course/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:full_course/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:full_course/features/blog/domain/repositories/blog_repository.dart';
import 'package:full_course/features/blog/domain/usecases/upload_blog.dart';
import 'package:full_course/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);

  sl.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
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

  sl.registerFactory<UserLogin>(
    () => UserLogin(
      sl<AuthRepository>(),
    ),
  );

  sl.registerFactory<CurrentUser>(
    () => CurrentUser(
      sl<AuthRepository>(),
    ),
  );

  sl.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUp: sl<UserSignUp>(),
      userLogin: sl<UserLogin>(),
      currentUser: sl<CurrentUser>(),
      appUserCubit: sl<AppUserCubit>(),
    ),
  );
}

void _initBlog() {
  sl.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      sl<SupabaseClient>(),
    ),
  );

  sl.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      sl<BlogRemoteDataSource>(),
    ),
  );

  sl.registerFactory<UploadBlog>(
    () => UploadBlog(sl<BlogRepository>()),
  );

  sl.registerLazySingleton(
    () => BlogBloc(
      sl<UploadBlog>(),
    ),
  );
}
