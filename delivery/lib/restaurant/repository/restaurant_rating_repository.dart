import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/dio/dio_provider.dart';
import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/common/model/pagination_params.dart';
import 'package:delivery/common/repository/base_pagination_respository.dart';
import 'package:delivery/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);

  return RestaurantRatingRepository(dio,
      baseUrl: 'http://$ip:3000/restaurant/$id/rating');
});

@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRespository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPaginationModel<RatingModel>> paginate({
    @Queries() PaginationParams? params = const PaginationParams(),
  });
}
