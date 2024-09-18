import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/const/data.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:delivery/restaurant/model/restaurant_model.dart';
import 'package:delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final res = await dio.get('http://$ip:3000/restaurant',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));

    return res.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: paginateRestaurant(),
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
              final item = snapshot.data![index];
              final parseItem = RestaurantModel.fromJson(
                json: item,
              );

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