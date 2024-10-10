import 'package:dartz/dartz.dart';
import 'package:test_study/core/error/failure.dart';
import 'package:test_study/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
