import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_study/core/error/exception.dart';
import 'package:test_study/core/error/failure.dart';
import 'package:test_study/data/models/weather_model.dart';
import 'package:test_study/data/repositories/weather_repository_impl.dart';
import 'package:test_study/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group('GetCurrentUser', () {
    test(
      'Data Source가 Request에 성공하여 현재 날씨를 잘 가져오는지',
      () async {
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenAnswer((_) async => testWeatherModel);

        final res = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        expect(res, equals(const Right(testWeatherEntity)));
      },
    );

    test(
      'Data Source가 Request에 실패하여 ServerException을 잘 발생시키는지',
      () async {
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(ServerException());

        final res = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        expect(res, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );

    test(
      'Internet 연결이 안되어있을 때',
      () async {
        when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
            .thenThrow(const SocketException('네트워크 연결 실패'));

        final res = await weatherRepositoryImpl.getCurrentWeather(testCityName);

        expect(
          res,
          equals(
            const Left(
              ConnectionFailure('Failed to connect to the network'),
            ),
          ),
        );
      },
    );
  });
}
