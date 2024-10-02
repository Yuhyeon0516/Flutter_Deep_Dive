import 'package:auth_bloc_study/common/bloc/button/button_state.dart';
import 'package:auth_bloc_study/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  void excute({dynamic params, required Usecase usecase}) async {
    emit(ButtonLoadingState());
    try {
      Either result = await usecase.call(param: params);

      result.fold((error) {
        emit(ButtonFailureState(errorMessage: error.toString()));
      }, (data) {
        emit(ButtonSuccessState());
      });
    } catch (e) {
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
