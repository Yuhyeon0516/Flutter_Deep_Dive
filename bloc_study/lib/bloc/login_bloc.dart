import 'dart:async';

import 'package:bloc_study/repository/auth/login_repository.dart';
import 'package:bloc_study/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository = LoginRepository();

  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onLoginApi);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  void _onLoginApi(LoginApi event, Emitter<LoginState> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    Map<String, String> data = {
      'email': state.email,
      'password': state.password,
    };

    await loginRepository.loginApi(data).then((value) {
      if (value.error.isNotEmpty) {
        emit(state.copyWith(postApiStatus: PostApiStatus.success));
      } else {
        (error, stackTrace) {
          emit(state.copyWith(
              error: value.error.toString(),
              postApiStatus: PostApiStatus.error));
        };
      }
    }).onError(
      (error, stackTrace) {
        emit(state.copyWith(
            error: error.toString(), postApiStatus: PostApiStatus.error));
      },
    );
  }
}
