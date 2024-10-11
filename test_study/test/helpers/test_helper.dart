import 'package:test_study/data/data_sources/remote_data_source.dart';
import 'package:test_study/domain/repositories/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:test_study/domain/usecases/get_current_weather.dart';

// mockito를 이용하여 mock class를 생성
@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUsecase,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
