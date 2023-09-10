import 'package:sqflite/sqlite_api.dart';

import 'package:tour_weather_tracker/src/entities/entities.dart';

class BaseRepository {
  final Database _database;

  BaseRepository(this._database);

  Future<int> insert(String table, Entity entity) async {
    return await _database.insert(table, entity.toMap());
  }

  Future<int> remove(String table, Entity entity) async {
    return await _database
        .delete(table, where: 'id = ?', whereArgs: [entity.id]);
  }
}
