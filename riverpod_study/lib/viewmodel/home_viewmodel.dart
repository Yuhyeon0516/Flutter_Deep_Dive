import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_study/model/coin.dart';
import 'package:riverpod_study/repository/coin_repository.dart';

final homeViewmodelProvider =
    AsyncNotifierProvider<HomeViewmodel, List<Coin>>(HomeViewmodel.new);

final getAllCoinsProvider = AutoDisposeFutureProvider<List<Coin>>((ref) {
  final homeViewmodel = ref.watch(homeViewmodelProvider.notifier);

  return homeViewmodel.getCoins();
});

class HomeViewmodel extends AsyncNotifier<List<Coin>> {
  late CoinRepository _coinRepository;

  @override
  List<Coin> build() {
    _coinRepository = ref.watch(coinRepositoryProvider);

    return [];
  }

  Future<List<Coin>> getCoins() async {
    final coins = await _coinRepository.getCoins();

    return switch (coins) {
      Left(value: final l) => throw l.message,
      Right(value: final r) => r,
    };
  }
}
