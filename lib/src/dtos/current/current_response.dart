import 'package:tour_weather_tracker/src/dtos/dtos.dart';

class CurrentResponse {
  final List<WeatherResponse> weather;
  final DateTime dateTime;

  CurrentResponse({
    required this.dateTime,
    required this.weather,
  });

  static DateTime _convertFromUnix(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  factory CurrentResponse.fromMap(Map<String, dynamic> data) {
    return CurrentResponse(
        dateTime: _convertFromUnix(data["dt"]),
        weather: _fromResultsToList(data["weather"]));
  }

  static List<WeatherResponse> _fromResultsToList(List<dynamic> maps) {
    List<WeatherResponse> results =
        maps.map((map) => WeatherResponse.fromMap(map)).toList();
    return results;
  }
}
