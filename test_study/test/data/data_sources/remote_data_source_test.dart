import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test_study/core/constants/constants.dart';
import 'package:test_study/core/error/exception.dart';
import 'package:test_study/data/data_sources/remote_data_source.dart';
import 'package:test_study/data/models/weather_model.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'New York';

  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {
      //상황
      when(mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'), 200));

      //실행
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //결과 비교
      expect(result, isA<WeatherModel>());
    });

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        when(
          mockHttpClient
              .get(Uri.parse(Urls.currentWeatherByName(testCityName))),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        final result =
            weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
