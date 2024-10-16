import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_bloc_retrofit/models/add_and_update_todo_model.dart';
import 'package:todo_bloc_retrofit/models/get_all_todo_model.dart';
import 'package:todo_bloc_retrofit/models/todo_model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/v1/todos')
  Future<GetAllTodoModel> getAllTodos();

  @POST('/v1/todos')
  Future<TodoModel> addTodo(
    @Body() AddAndUpdateTodoModel todo,
  );

  @PUT('/v1/todos/{id}')
  Future<TodoModel> updateTodo(
    @Path() String id,
    @Body() AddAndUpdateTodoModel todo,
  );

  @DELETE('/v1/todos/{id}')
  Future<List<GetAllTodoModel>> deleteTodo(
    @Path() String id,
  );
}
