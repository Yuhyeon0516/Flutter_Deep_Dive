import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/common/model/pagination_params.dart';
import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPaginationModel) {
    return null;
  }

  return state.data.firstWhere((e) => e.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);

    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    // 가져올 게시물 갯수
    int fetchCount = 20,
    // 데이터를 더 가져올건지
    bool fetchMore = false,
    // 강제로 데이터 초기화
    bool forceRefrech = false,
  }) async {
    try {
      // State 상태별로 분리
      // 1. CursorPaginationModel - 데이터가 있는 상태
      // 2. CursorPaginationLoading - 데이터가 로딩 중인 상태
      // 3. CursorPaginationError - 에러가 있는 상태
      // 4. CursorpaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올 때
      // 5. CursorPaginationFetchMore - 추가 데이터를 요청할 때

      // 바로 반환되는 상황
      // 1. hasMore가 false인 상황이면 (다음 데이터가 없음)
      // 2. 로딩중이나 fetchMore가 true이면 (맨 아래까지 도달하여 다시 데이터를 가져올때)
      //    fetchMore가 false이면 새로고침을 해야하는 상황

      if (state is CursorPaginationModel && !forceRefrech) {
        final parseState = state as CursorPaginationModel;

        if (!parseState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // pagination params 생성
      PaginationParams paginationParams = PaginationParams(count: fetchCount);

      // fetchMore
      // 데이터를 더 가져올때
      if (fetchMore) {
        final parseState = state as CursorPaginationModel;

        state = CursorPaginationFetchingMore(
          meta: parseState.meta,
          data: parseState.data,
        );

        paginationParams =
            paginationParams.copyWith(after: parseState.data.last.id);
      } else {
        if (state is CursorPaginationModel && !forceRefrech) {
          final parseState = state as CursorPaginationModel;

          state = CursorPaginationRefetching(
            meta: parseState.meta,
            data: parseState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      final res = await repository.paginate(params: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final parseState = state as CursorPaginationFetchingMore;

        state = res.copyWith(
          data: [
            ...parseState.data,
            ...res.data,
          ],
        );
      } else {
        state = res;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못하였습니다.');
    }
  }

  void getDetail({
    required String id,
  }) async {
    if (state is! CursorPaginationModel) {
      await paginate();
    }

    if (state is! CursorPaginationModel) {
      return;
    }

    final parseState = state as CursorPaginationModel;
    final res = await repository.getRestaurantDetail(id: id);

    state = parseState.copyWith(
      data: parseState.data
          .map<RestaurantModel>((e) => e.id == id ? res : e)
          .toList(),
    );
  }
}