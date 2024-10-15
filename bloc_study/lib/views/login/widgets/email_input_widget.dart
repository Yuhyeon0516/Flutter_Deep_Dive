import 'package:bloc_study/bloc/login_bloc.dart';
import 'package:bloc_study/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInputWidget extends StatelessWidget {
  final FocusNode focusNode;

  const EmailInputWidget({
    super.key,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => current.email != previous.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          focusNode: focusNode,
          decoration: const InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email을 입력해주세요.';
            }

            if (!Validations.emailValidator(value)) {
              return 'Email 형식을 맞춰주세요.';
            }

            return null;
          },
          onFieldSubmitted: (value) {},
        );
      },
    );
  }
}
