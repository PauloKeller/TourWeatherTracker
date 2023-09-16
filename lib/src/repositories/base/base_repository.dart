import 'package:sqflite/sqlite_api.dart';

import 'package:tour_weather_tracker/src/entities/entities.dart';

class BaseRepository {
  final Database _database;

  BaseRepository(this._database);

  Future<int> insert(String table, Entity entity) async {
    return await _database.insert(table, entity.toMap());
  }

  Future<int> delete(String table, Entity entity) async {
    return await _database
        .delete(table, where: 'id = ?', whereArgs: [entity.id]);
  }

  Future<int> deleteBy(String table, String parameterName, dynamic parameter) async {
    return await _database
        .delete(table, where: '$parameterName = ?', whereArgs: [parameter]);
  }

  Future<List<Map<String, Object?>>> findAll(String table) async {
    return await _database.query(table);
  }

  Future<List<Map<String, Object?>>> findBy(
      String table, String parameterName, dynamic parameter) async {
    return await _database
        .query(table, where: '$parameterName = ?', whereArgs: [parameter]);
  }
}
