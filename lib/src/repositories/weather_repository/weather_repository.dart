import 'package:tour_weather_tracker/src/entities/entities.dart';
import 'package:tour_weather_tracker/src/repositories/repositories.dart';

abstract class WeatherRepositoryInterface {
  Future<int> saveCurrent(CurrentWeatherEntity weather);

  Future<int> removeCurrent(CurrentWeatherEntity weather);
}

class WeatherRepository extends BaseRepository
    implements WeatherRepositoryInterface {
  WeatherRepository(super.database);

  final _currentWeatherTable = "current";

  @override
  Future<int> saveCurrent(CurrentWeatherEntity weather) {
    return insert(_currentWeatherTable, weather);
  }

  @override
  Future<int> removeCurrent(CurrentWeatherEntity weather) {
    return remove(_currentWeatherTable, weather);
  }
}
