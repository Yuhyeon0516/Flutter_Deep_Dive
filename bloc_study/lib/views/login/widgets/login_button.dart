import 'package:bloc_study/bloc/login_bloc.dart';
import 'package:bloc_study/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.postApiStatus == PostApiStatus.error) {
          // 에러 발생 시
          print(state.error);
        }

        if (state.postApiStatus == PostApiStatus.success) {
          // 성공 시
          print('success');
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginApi());
              }
            },
            child: const Text('Login'),
          );
        },
      ),
    );
  }
}
