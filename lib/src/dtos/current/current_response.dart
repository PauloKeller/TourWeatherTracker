import 'package:tour_weather_tracker/src/dtos/dtos.dart';

class CurrentResponse {
  final List<WeatherResponse> weather;

  CurrentResponse({
    required this.weather
  });

  factory CurrentResponse.fromMap(Map<String, dynamic> data) {
    return CurrentResponse(weather: _fromResultsToList(data["weather"]));
  }

  static List<WeatherResponse> _fromResultsToList(List<dynamic> maps) {
    List<WeatherResponse> results = maps.map((map) => WeatherResponse.
    fromMap(map)).toList();
    return results;
  }
}