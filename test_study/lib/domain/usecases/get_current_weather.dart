import 'package:dartz/dartz.dart';
import 'package:test_study/core/error/failure.dart';
import 'package:test_study/domain/entities/weather.dart';
import 'package:test_study/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUsecase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUsecase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) async {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
