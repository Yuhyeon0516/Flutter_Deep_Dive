import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test_study/domain/entities/weather.dart';
import 'package:test_study/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  late MockWeatherRepository mockWeatherRepository;

  // usecase에서 테스트이기 때문에 repository는 mock으로 대체하고 usecase에 mock repository를 넣어줌
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUsecase = GetCurrentWeatherUsecase(mockWeatherRepository);
  });

  // repository에서 return해줄 entity를 정의
  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  // usecase에서 요청할 cityname을 정의
  const testCityName = 'New York';

  test('get current weather', () async {
    // mock repository의 getCurrentWeather가 호출되면 testWeatherDetail을 return하도록 정의
    when(
      mockWeatherRepository.getCurrentWeather(testCityName),
    ).thenAnswer(
      (_) async => const Right(testWeatherDetail),
    );

    // 실제 usecase를 동작시킴 -> 여기서 mock repository에 설정해둔 값이 나옴
    final res = await getCurrentWeatherUsecase.execute(testCityName);

    // res의 값이 정의해둔 testWeatherDetail과 일치하는지 비교
    expect(res, const Right(testWeatherDetail));
  });
}
