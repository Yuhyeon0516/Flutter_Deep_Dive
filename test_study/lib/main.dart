import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_study/presentation/pages/weather_page.dart';
import 'package:test_study/service_locator.dart';

import 'presentation/bloc/weather_bloc.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<WeatherBloc>(),
        )
      ],
      child: const MaterialApp(
        home: WeatherPage(),
      ),
    );
  }
}
