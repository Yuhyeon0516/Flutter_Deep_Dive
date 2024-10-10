import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_study/data/models/weather_model.dart';
import 'package:test_study/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'Seoul',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  test(
    'weather model의 sub class가 weather entity인지',
    () async {
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );

  test(
    'json을 weather model로',
    () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_weather_response.json'),
      );

      final res = WeatherModel.fromJson(jsonMap);

      expect(res, equals(testWeatherModel));
    },
  );

  test(
    'weather model을 json으로',
    () async {
      final res = testWeatherModel.toJson();

      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 292.87,
          'pressure': 1012,
          'humidity': 70,
        },
        'name': 'Seoul',
      };

      expect(res, equals(expectedJsonMap));
    },
  );
}
