import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_course/core/secrets/app_secrets.dart';
import 'package:full_course/core/theme/app_theme.dart';
import 'package:full_course/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:full_course/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:full_course/features/auth/domain/usecases/user_sign_up.dart';
import 'package:full_course/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:full_course/features/auth/presentation/pages/signin_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImpl(
              AuthRemoteDataSourceImpl(
                supabase.client,
              ),
            ),
          ),
        ),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "blog app",
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: const SigninPage(),
    );
  }
}
