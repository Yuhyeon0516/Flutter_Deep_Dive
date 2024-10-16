part of 'get_todo_list_cubit.dart';

@immutable
sealed class GetTodoListState {}

final class GetTodoListInitial extends GetTodoListState {}

final class GetTodoListNetworkError extends GetTodoListState {}

final class GetTodoListLoading extends GetTodoListState {}

final class GetTodoListLoaded extends GetTodoListState {
  final List<Items> all;
  final List<Items> todo;
  final List<Items> done;

  GetTodoListLoaded(this.all, this.todo, this.done);
}

final class GetTodoListError extends GetTodoListState {}
