import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/common/model/model_with_id.dart';
import 'package:delivery/common/model/pagination_params.dart';
import 'package:delivery/common/repository/base_pagination_respository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _PaginationInfo {
  // 가져올 게시물 갯수
  final int fetchCount;
  // 데이터를 더 가져올건지
  final bool fetchMore;
  // 강제로 데이터 초기화
  final bool forceRefrech;

  _PaginationInfo({
    this.fetchCount = 20,
    this.fetchMore = false,
    this.forceRefrech = false,
  });
}

class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRespository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;
  final paginationThrottle = Throttle(
    const Duration(seconds: 3),
    initialValue: _PaginationInfo(),
    checkEquality: false,
  );

  PaginationProvider({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();

    paginationThrottle.values.listen((state) {
      _throttlePagination(state);
    });
  }

  Future<void> paginate({
    // 가져올 게시물 갯수
    int fetchCount = 20,
    // 데이터를 더 가져올건지
    bool fetchMore = false,
    // 강제로 데이터 초기화
    bool forceRefrech = false,
  }) async {
    paginationThrottle.setValue(_PaginationInfo(
      fetchMore: fetchMore,
      fetchCount: fetchCount,
      forceRefrech: forceRefrech,
    ));
  }

  _throttlePagination(_PaginationInfo info) async {
    final fetchCount = info.fetchCount;
    final fetchMore = info.fetchMore;
    final forceRefrech = info.forceRefrech;

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
        final parseState = state as CursorPaginationModel<T>;

        state = CursorPaginationFetchingMore(
          meta: parseState.meta,
          data: parseState.data,
        );

        paginationParams =
            paginationParams.copyWith(after: parseState.data.last.id);
      } else {
        if (state is CursorPaginationModel && !forceRefrech) {
          final parseState = state as CursorPaginationModel<T>;

          state = CursorPaginationRefetching<T>(
            meta: parseState.meta,
            data: parseState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }

      final res = await repository.paginate(params: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final parseState = state as CursorPaginationFetchingMore<T>;

        state = res.copyWith(
          data: [
            ...parseState.data,
            ...res.data,
          ],
        );
      } else {
        state = res;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 가져오지 못하였습니다.');
    }
  }
}
