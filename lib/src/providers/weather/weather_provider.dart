import 'package:dio/dio.dart';

import 'package:tour_weather_tracker/src/providers/providers.dart';
import 'package:tour_weather_tracker/src/dtos/dtos.dart';

abstract class HeroesProviderInterface {
  Future<CurrentResponse> getCurrentWeather();
  Future<ForecastResponse> getForecastWeather();
}

enum EndPoints {
  current,
  forecast
}

class WeatherProvider extends BaseProvider implements HeroesProviderInterface {
  WeatherProvider(Dio dio) : super(dio);

  String _getEndPoint(EndPoints endPoint) {
    switch (endPoint) {
      case EndPoints.current:
        return '/weather';
      case EndPoints.forecast:
        return '/forecast';
    }
  }

  @override
  Future<CurrentResponse> getCurrentWeather() async {
    const apiKey = "41729c5a20961ea7cf6edc99c6553ffc";
    const cityName = "Silverstone";
    final response = await get("/weather?q=$cityName&appid=$apiKey");
    return CurrentResponse.fromMap(response.data);
  }

  @override
  Future<ForecastResponse> getForecastWeather() async {
    const apiKey = "41729c5a20961ea7cf6edc99c6553ffc";
    const cityName = "Silverstone";
    final response = await get("/forecast?q=$cityName&appid=$apiKey");
    return ForecastResponse.fromMap(response.data);
  }
}