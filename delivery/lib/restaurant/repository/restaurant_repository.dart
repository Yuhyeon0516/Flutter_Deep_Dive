import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/dio/dio_provider.dart';
import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/common/model/pagination_params.dart';
import 'package:delivery/common/repository/base_pagination_respository.dart';
import 'package:delivery/restaurant/model/restaurant_detail_model.dart';
import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip:3000/restaurant');

    return repository;
  },
);

@RestApi()
abstract class RestaurantRepository
    implements IBasePaginationRespository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPaginationModel<RestaurantModel>> paginate({
    @Queries() PaginationParams? params = const PaginationParams(),
  });

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
