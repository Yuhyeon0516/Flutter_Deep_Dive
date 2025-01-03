import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/util/error_text.dart';
import 'package:riverpod_study/util/loader.dart';
import 'package:riverpod_study/viewmodel/home_viewmodel.dart';
import 'package:riverpod_study/widget/coin_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coins = ref.watch(getAllCoinsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: coins.when(
        data: (data) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: CoinItem(
                  coin: data[index],
                ),
              );
            },
          );
        },
        error: (error, stack) {
          return ErrorText(
            error: error.toString(),
          );
        },
        loading: () {
          return const Loader();
        },
      ),
    );
  }
}
