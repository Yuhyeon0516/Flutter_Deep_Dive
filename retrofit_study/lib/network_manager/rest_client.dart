import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit_study/models/array_user_list.dart';
import 'package:retrofit_study/models/object_users_list.dart';
import 'package:retrofit_study/models/update_job.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // Get
  @GET('https://reqres.in/api/users?page=2')
  Future<ObjectUsersList> getObjectUsersList();

  @GET('https://jsonplaceholder.typicode.com/posts')
  Future<List<ArrayUserList>> getArrayUsersList();

  // Post
  @POST('https://reqres.in/api/users')
  Future<dynamic> postJob(
    @Field() String name,
    @Field() String job,
  );

  // Put
  @PUT('https://reqres.in/api/users/{id}')
  Future<UpdateJob> putJob(
    @Path('id') String id,
    @Field() String name,
    @Field() String job,
  );

  // Patch
  @PATCH('https://reqres.in/api/users/{id}')
  Future<UpdateJob> patchJob(
    @Path('id') String id,
    @Field() String name,
    @Field() String job,
  );

  // Multi Part
  // https://fakeapi.platzi.com
  @POST('https://api.escuelajs.co/api/v1/files/upload')
  @MultiPart()
  @Headers({
    'Content-Type': 'multipart/form-data',
  })
  Future<dynamic> uploadImage(
    @Part(name: 'file') File file,
  );

  @DELETE('https://reqres.in/api/users/{id}')
  Future<dynamic> deleteJob(
    @Path('id') String id,
  );
}
