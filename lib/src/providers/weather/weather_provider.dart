import 'package:dio/dio.dart';

import 'package:tour_weather_tracker/src/providers/providers.dart';
import 'package:tour_weather_tracker/src/dtos/dtos.dart';

abstract class WeatherProviderInterface {
  Future<CurrentResponse> fetchCurrentWeather(String cityName);
  Future<ForecastResponse> fetchForecastWeather(String cityName);
}

enum EndPoints {
  current,
  forecast
}

class WeatherProvider extends BaseProvider implements WeatherProviderInterface {
  WeatherProvider(Dio dio) : super(dio);
  final apiKey = "41729c5a20961ea7cf6edc99c6553ffc";

  @override
  Future<CurrentResponse> fetchCurrentWeather(String cityName) async {
    final response = await get("/weather?q=$cityName&appid=$apiKey");
    return CurrentResponse.fromMap(response.data);
  }

  @override
  Future<ForecastResponse> fetchForecastWeather(String cityName) async {
    final response = await get("/forecast?q=$cityName&appid=$apiKey");
    return ForecastResponse.fromMap(response.data);
  }
}