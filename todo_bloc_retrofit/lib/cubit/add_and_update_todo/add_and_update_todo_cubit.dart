import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_retrofit/models/add_and_update_todo_model.dart';
import 'package:todo_bloc_retrofit/network_manager/injection.dart';
import 'package:todo_bloc_retrofit/utils/connectivity.dart';
import 'package:todo_bloc_retrofit/utils/snackbar.dart';

part 'add_and_update_todo_state.dart';

class AddAndUpdateTodoCubit extends Cubit<AddAndUpdateTodoState> {
  AddAndUpdateTodoCubit() : super(AddAndUpdateTodoInitial());

  addAndUpdateTodo(
    BuildContext context,
    String type,
    AddAndUpdateTodoModel todo,
    String id,
  ) async {
    if (await isNetworkAvailable()) {
      emit(AddAndUpdateTodoLoading());

      if (type == 'add') {
        client.addTodo(todo).then(
          (value) {
            emit(AddAndUpdateTodoLoaded());

            if (context.mounted) {
              toastMessage('Add Success');
              Navigator.pop(context);
            }
          },
        ).onError(
          (error, stackTrace) {
            emit(AddAndUpdateTodoError());
          },
        );
      } else {
        client.updateTodo(id, todo).then(
          (value) {
            emit(AddAndUpdateTodoLoaded());

            if (context.mounted) {
              toastMessage('Update Success');
              Navigator.pop(context);
            }
          },
        ).onError(
          (error, stackTrace) {
            emit(AddAndUpdateTodoError());
          },
        );
      }
    } else {
      emit(AddAndUpdateTodoNetworkError());
    }
  }
}
