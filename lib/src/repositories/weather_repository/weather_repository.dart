import 'package:tour_weather_tracker/src/entities/entities.dart';
import 'package:tour_weather_tracker/src/repositories/repositories.dart';

abstract class WeatherRepositoryInterface {
  Future<int?> save(WeatherEntity weather);

  Future<int?> remove(WeatherEntity weather);

  Future<List<WeatherEntity?>> getAll();

  Future<List<WeatherEntity?>> getById(int id);

  Future<List<WeatherEntity?>> getByCity(String city);

  Future<int?> clear(String city);
}

// TODO: Create Error exceptions for this repository

class WeatherRepository extends BaseRepository
    implements WeatherRepositoryInterface {
  WeatherRepository(super.database);

  final _table = "weather";

  @override
  Future<int?> save(WeatherEntity weather) async {
    try {
      return await insert(_table, weather);
    } catch (error) {
      return null;
    }
  }

  @override
  Future<int?> remove(WeatherEntity weather) async {
    try {
      return await delete(_table, weather);
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<WeatherEntity?>> getAll() async {
    try {
      final maps = await findAll(_table);
      final results = maps.map((map) => WeatherEntity.fromMap(map)).toList();
      return results;
    } catch(error) {
      return [];
    }
  }

  @override
  Future<List<WeatherEntity?>> getById(int id) async {
    try {
      final maps = await findBy(_table, "id", id);
      final results = maps.map((map) => WeatherEntity.fromMap(map)).toList();
      return results;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<List<WeatherEntity?>> getByCity(String city) async {
    try {
      final maps = await findBy(_table, "city", city);
      final results = maps.map((map) => WeatherEntity.fromMap(map)).toList();
      return results;
    } catch (error) {
      return [];
    }
  }

  @override
  Future<int?> clear(String city) async {
    try {
      return await deleteBy(_table, "city", city);
    } catch (error) {
      return null;
    }
  }
}
