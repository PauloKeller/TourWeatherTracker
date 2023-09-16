import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'package:tour_weather_tracker/src/modules/modules.dart';
import 'package:tour_weather_tracker/src/providers/providers.dart';
import 'package:tour_weather_tracker/src/repositories/repositories.dart';

class App extends StatelessWidget {
  final WeatherRepository _repository;

  const App(this._repository, {Key? key}) : super(key: key);

  static final _provider = WeatherProvider(
      Dio(BaseOptions(baseUrl: "https://api.openweathermap.org/data/2.5")));

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DetailsBlocInterface>(
            create: (context) => DetailsBloc(_provider, _repository)),
      ],
      child: MaterialApp(
        title: "Tour Weather Tracker",
        home: HomePage(),
      ),
    );
  }
}
