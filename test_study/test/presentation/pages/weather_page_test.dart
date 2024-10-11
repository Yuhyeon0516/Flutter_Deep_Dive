import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:test_study/domain/entities/weather.dart';
import 'package:test_study/presentation/bloc/weather_bloc.dart';
import 'package:test_study/presentation/bloc/weather_event.dart';
import 'package:test_study/presentation/bloc/weather_state.dart';
import 'package:test_study/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  testWidgets(
    'WeatherEmpty state에서 WeatherLoading state로 변경',
    (widgetTester) async {
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      // WeatherPage를 build
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      final textField = find.byType(TextField);

      // TextField가 하나인지
      expect(textField, findsOneWidget);

      // TextField에 New York을 입력하고 build
      await widgetTester.enterText(textField, 'New York');
      await widgetTester.pump();

      // 현재 Page에 New York이라는 text가 하나 있는지
      expect(find.text('New York'), findsOneWidget);
    },
  );

  testWidgets(
    'WeatherLoading state일때 CircularProgressIndicator가 나타나는지',
    (widgetTester) async {
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      // WeatherPage를 build
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      // CircularProgressIndicator가 하나 있는지
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'WeatherLoaded 상태일 때 날씨 데이터를 가지고있는 Widget이 나타나는지',
    (widgetTester) async {
      when(() => mockWeatherBloc.state)
          .thenReturn(const WeatherLoaded(testWeather));

      // WeatherPage를 build
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      // 모든 타이머나 애니메이션이 완료될 때까지 대기
      await widgetTester.pumpAndSettle();

      // weather_data key를 가지고있는 widget이 하나 있는지
      expect(find.byKey(const Key('weather_data')), findsOneWidget);
    },
  );
}
