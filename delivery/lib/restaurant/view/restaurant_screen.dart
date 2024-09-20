import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/dio/dio_provider.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:delivery/restaurant/repository/restaurant_repository.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.read(dioProvider);

    final res =
        await RestaurantRepository(dio, baseUrl: 'http://$ip:3000/restaurant')
            .paginate();

    return res.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<RestaurantModel>>(
      future: paginateRestaurant(ref),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(
            child: Text('데이터를 가져오는 중 에러가 발생하였습니다.'),
          );
        }

        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: PRIMARY_COLOR,
            ),
          );
        }

        return ListView.separated(
            itemBuilder: (_, index) {
              final parseItem = snapshot.data![index];

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
            itemCount: snapshot.data!.length);
      },
    );
  }
}
