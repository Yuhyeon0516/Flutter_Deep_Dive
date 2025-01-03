import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_study/model/coin_detail.dart';
import 'package:riverpod_study/repository/coin_repository.dart';

final coinViewmodelProvider =
    AsyncNotifierProvider<CoinDetailViewmodel, CoinDetail?>(
        CoinDetailViewmodel.new);

final coinDetail = FutureProvider.family((ref, String coinId) {
  final coinDetail = ref.watch(coinViewmodelProvider.notifier);

  return coinDetail.getCoinDetail(coinId);
});

class CoinDetailViewmodel extends AsyncNotifier<CoinDetail?> {
  late CoinRepository _coinRepository;

  @override
  CoinDetail? build() {
    _coinRepository = ref.watch(coinRepositoryProvider);

    return null;
  }

  Future<CoinDetail> getCoinDetail(String coinId) async {
    final coinDetail = await _coinRepository.getCoinDetail(coinId);

    return switch (coinDetail) {
      Left(value: final l) => throw l.message,
      Right(value: final r) => r,
    };
  }
}
