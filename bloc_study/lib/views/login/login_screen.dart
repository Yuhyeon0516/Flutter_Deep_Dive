import 'package:bloc_study/bloc/login_bloc.dart';
import 'package:bloc_study/views/login/widgets/email_input_widget.dart';
import 'package:bloc_study/views/login/widgets/login_button.dart';
import 'package:bloc_study/views/login/widgets/password_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EmailInputWidget(focusNode: emailFocusNode),
              const SizedBox(
                height: 20,
              ),
              PasswordInputWidget(focusNode: passwordFocusNode),
              const SizedBox(
                height: 50,
              ),
              LoginButton(formKey: formKey),
            ],
          ),
        ),
      ),
    );
  }
}
