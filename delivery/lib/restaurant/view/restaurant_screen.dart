import 'package:delivery/common/model/cursor_pagination_model.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/provider/restaurant_provider.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 도달하였다면
    // 새로운 데이터를 요청
    if (controller.offset >
        controller.position.maxScrollExtent -
            MediaQuery.of(context).size.height / 2) {
      ref.read(restaurantProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    final cp = data as CursorPaginationModel;

    return ListView.separated(
      controller: controller,
      itemCount: cp.data.length + 1,
      itemBuilder: (_, index) {
        if (index == cp.data.length) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: data is CursorPaginationFetchingMore
                  ? const CircularProgressIndicator()
                  : const Text('마지막 데이터입니다.'),
            ),
          );
        }

        final parseItem = cp.data[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  id: parseItem.id,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RestaurantCard.fromModel(
              model: parseItem,
            ),
          ),
        );
      },
      separatorBuilder: (_, index) {
        return const SizedBox(height: 16);
      },
    );
  }
}
