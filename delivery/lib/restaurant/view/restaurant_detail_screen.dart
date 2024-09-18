import 'package:delivery/common/layout/default_layout.dart';
import 'package:delivery/product/component/product_card.dart';
import 'package:delivery/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '불타는 떡볶이',
        child: CustomScrollView(
          slivers: [
            renderTop(),
            renderLabel(),
            renderProducts(),
          ],
        )

        // Column(
        //   children: [
        //     RestaurantCard(
        //       image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
        //       name: '불타는 떡볶이',
        //       tags: const ['떡볶이', '맛있음', '치즈'],
        //       ratingsCount: 100,
        //       deliveryTime: 40,
        //       deliveryFee: 2000,
        //       ratings: 4.52,
        //       isDetail: true,
        //       detail: '정말 맛있어요.',
        //     ),
        //     const Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 16),
        //       child: ProductCard(),
        //     ),
        //   ],
        // ),
        );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
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
    );
  }

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return const Padding(
              padding: EdgeInsets.only(top: 16),
              child: ProductCard(),
            );
          },
          childCount: 10,
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
