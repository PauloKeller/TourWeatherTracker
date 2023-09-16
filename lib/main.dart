import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:tour_weather_tracker/src/app.dart';
import 'package:tour_weather_tracker/src/repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
    join(await getDatabasesPath(), 'weather.db'),
    onCreate: (db, version) {
      return db.execute("""
        CREATE TABLE weather(id INTEGER PRIMARY KEY, city TEXT, date_time INTEGER, main TEXT)
      """);
    },
    version: 1,
  );

  final repository = WeatherRepository(database);

  runApp(App(repository));
}
