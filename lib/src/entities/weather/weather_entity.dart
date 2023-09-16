import 'package:tour_weather_tracker/src/entities/entities.dart';

class WeatherEntity implements Entity {
  @override
  int? id;
  final String city;
  final DateTime dateTime;
  final String main;

  WeatherEntity({
    this.id,
    required this.city,
    required this.dateTime,
    required this.main,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'main': main,
      'date_time': _convertToUnix(),
    };
  }

  int _convertToUnix() {
    return dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
  }

  static DateTime _convertFromUnix(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  factory WeatherEntity.fromMap(Map<String, dynamic> map) {
    return WeatherEntity(
      city: map["city"],
      dateTime: _convertFromUnix(map["date_time"]),
      main: map["main"],
    );
  }
}
