import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/const/data.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
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

              return RestaurantCard(
                image: Image.network(
                  'http://$ip:3000/${item['thumbUrl']}',
                  fit: BoxFit.cover,
                ),
                name: item['name'],
                tags: List<String>.from(item['tags']),
                ratingsCount: item['ratingsCount'],
                deliveryTime: item['deliveryTime'],
                deliveryFee: item['deliveryFee'],
                ratings: item['ratings'],
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
