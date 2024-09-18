import 'package:delivery/common/layout/default_layout.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: Column(
        children: [
          RestaurantCard(
            image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
            name: '불타는 떡볶이',
            tags: const ['떡볶이', '맛있음', '치즈'],
            ratingsCount: 100,
            deliveryTime: 40,
            deliveryFee: 2000,
            ratings: 4.52,
            isDetail: true,
            detail: '정말 맛있어요.',
          ),
        ],
      ),
    );
  }
}
