import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_course/core/theme/app_theme.dart';
import 'package:full_course/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:full_course/features/auth/presentation/pages/signin_page.dart';
import 'package:full_course/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => sl<AuthBloc>(),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

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
