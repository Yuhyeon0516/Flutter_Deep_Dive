import 'package:test_study/domain/repositories/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// mockito를 이용하여 mock class를 생성
@GenerateMocks(
  [
    WeatherRepository,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
