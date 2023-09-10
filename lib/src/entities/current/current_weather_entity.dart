import 'package:tour_weather_tracker/src/entities/entities.dart';

class CurrentWeatherEntity implements Entity {
  @override
  final int id;
  final String city;
  final int weatherId;
  final String main;
  final String description;
  final String icon;

  CurrentWeatherEntity({
    required this.id,
    required this.city,
    required this.weatherId,
    required this.main,
    required this.description,
    required this.icon,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city': city,
      'weather_id': weatherId,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  @override
  set id(int _id) {
    id = _id;
  }
}
