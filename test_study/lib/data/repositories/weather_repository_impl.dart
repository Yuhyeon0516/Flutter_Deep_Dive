import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:test_study/core/error/exception.dart';
import 'package:test_study/core/error/failure.dart';
import 'package:test_study/data/data_sources/remote_data_source.dart';
import 'package:test_study/domain/entities/weather.dart';
import 'package:test_study/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl(this.weatherRemoteDataSource);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
