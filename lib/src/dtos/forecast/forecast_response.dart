import 'package:tour_weather_tracker/src/dtos/dtos.dart';

class ForecastResponse {
  final List<ForecastListItem> list;

  ForecastResponse({
    required this.list,
  });

  factory ForecastResponse.fromMap(Map<String, dynamic> data) {
    return ForecastResponse(list: _fromResultsToList(data["list"]));
  }

  static List<ForecastListItem> _fromResultsToList(List<dynamic> maps) {
    List<ForecastListItem> results =
        maps.map((map) => ForecastListItem.fromMap(map)).toList();
    return results;
  }
}

class ForecastListItem {
  DateTime dateTime;
  List<WeatherResponse> weather;

  ForecastListItem({
    required this.dateTime,
    required this.weather,
  });

  static DateTime _convertFromUnix(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  factory ForecastListItem.fromMap(Map<String, dynamic> data) {
    return ForecastListItem(
        dateTime: _convertFromUnix(data["dt"]),
        weather: _fromResultsToList(data["weather"]));
  }

  static List<WeatherResponse> _fromResultsToList(List<dynamic> maps) {
    List<WeatherResponse> results =
        maps.map((map) => WeatherResponse.fromMap(map)).toList();
    return results;
  }
}
