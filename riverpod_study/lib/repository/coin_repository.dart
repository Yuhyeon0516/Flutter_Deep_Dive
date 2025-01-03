import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_study/config/app_config.dart';
import 'package:riverpod_study/core/app_failure.dart';
import 'package:riverpod_study/model/coin.dart';
import 'package:riverpod_study/model/coin_detail.dart';

final coinRepositoryProvider = Provider((ref) => CoinRepository());

class CoinRepository {
  static var client = Dio();

  Future<Either<AppFailure, List<Coin>>> getCoins() async {
    const url = 'https://${AppConfig.baseUrl}${AppConfig.coinsUrl}';

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        return Right(coinFromJson(response.data));
      } else {
        return Left(AppFailure(message: response.statusMessage ?? ''));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, CoinDetail>> getCoinDetail(String coinId) async {
    final url = 'https://${AppConfig.baseUrl}${AppConfig.coinsUrl}/$coinId';

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        return Right(CoinDetail.fromJson(response.data));
      } else {
        return Left(AppFailure(message: response.statusMessage ?? ''));
      }
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
