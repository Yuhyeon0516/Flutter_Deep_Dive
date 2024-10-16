import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_retrofit/models/get_all_todo_model.dart';
import 'package:todo_bloc_retrofit/network_manager/injection.dart';
import 'package:todo_bloc_retrofit/utils/connectivity.dart';

part 'get_todo_list_state.dart';

class GetTodoListCubit extends Cubit<GetTodoListState> {
  GetTodoListCubit() : super(GetTodoListInitial());

  getTodoList() async {
    if (await isNetworkAvailable()) {
      emit(GetTodoListLoading());

      client.getAllTodos().then(
        (value) {
          List<Items> todo = [];
          List<Items> done = [];

          for (var item in value.items!) {
            if (item.isCompleted == true) {
              done.add(item);
            } else {
              todo.add(item);
            }
          }

          emit(GetTodoListLoaded(value.items!, todo, done));
        },
      ).onError(
        (error, stackTrace) {
          emit(GetTodoListError());
        },
      );
    } else {
      emit(GetTodoListNetworkError());
    }
  }
}
