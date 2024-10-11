import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_study/core/error/failure.dart';
import 'package:test_study/domain/entities/weather.dart';
import 'package:test_study/presentation/bloc/weather_bloc.dart';
import 'package:test_study/presentation/bloc/weather_event.dart';
import 'package:test_study/presentation/bloc/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUsecase mockGetCurrentWeatherUsecase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUsecase = MockGetCurrentWeatherUsecase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUsecase);
  });

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('Bloc의 초기 상태가 WeatherEmpty인지', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'OnCityChanged Event가 발생 후 데이터를 성공적으로 가져왔을 때 WeatherLoading, WeatherLoaded State를 잘 나타내는지',
    build: () {
      when(mockGetCurrentWeatherUsecase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeather));

      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeather),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'OnCityChanged Event가 발생 후 데이터를 가져오는데 실패했을 때 WeatherLoading, WeatherFailure State를 잘 나타내는지',
    build: () {
      when(mockGetCurrentWeatherUsecase.execute(testCityName))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailue('Server failure'),
    ],
  );
}
