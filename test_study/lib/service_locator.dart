import 'package:get_it/get_it.dart';
import 'package:test_study/domain/usecases/get_current_weather.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void setupLocator() {
  // bloc
  sl.registerFactory(() => WeatherBloc(sl()));

  // usecase
  sl.registerLazySingleton(() => GetCurrentWeatherUsecase(sl()));

  // repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(sl()),
  );

  // data source
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // external
  sl.registerLazySingleton(() => http.Client());
}
