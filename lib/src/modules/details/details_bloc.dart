import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:tour_weather_tracker/src/providers/providers.dart';
import 'package:tour_weather_tracker/src/entities/entities.dart';
import 'package:tour_weather_tracker/src/repositories/repositories.dart';
import 'package:tour_weather_tracker/src/dtos/dtos.dart';

abstract class DetailsBlocInterface with ChangeNotifier {
  Future<void> loadData(String cityName);
  UnmodifiableListView<WeatherEntity?> get weathers;
  String? get errorMessage;
  bool get isLoading;
}

class DetailsBloc with ChangeNotifier implements DetailsBlocInterface {
  final WeatherProviderInterface _weatherProvider;
  final WeatherRepositoryInterface _weatherRepository;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  String? get errorMessage => _errorMessage;

  @override
  bool get isLoading => _isLoading;

  // TODO: Create a <ViewModel>, decouple entity from the view
  List<WeatherEntity?> _cachedWeathers = [];

  @override
  UnmodifiableListView<WeatherEntity?> get weathers =>
      UnmodifiableListView(_cachedWeathers);

  DetailsBloc(this._weatherProvider, this._weatherRepository);

  @override
  Future<void> loadData(String cityName) async {
    try {
      _isLoading = true;
      _cachedWeathers = [];
      notifyListeners();

      final hasInternetConnection = await checkInternetConnection();

      if (hasInternetConnection) {
        await fetchWeather(cityName);
      } else {
        _cachedWeathers = await _weatherRepository.getByCity(cityName);
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = "Something goes wrong please contact the support team";
      notifyListeners();
    }
  }

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        return true;
      case ConnectivityResult.wifi:
        return true;
      default:
          return false;
    }
  }

  Future fetchWeather(String cityName) async {
    final response = await _weatherProvider.fetchForecastWeather(cityName);
    final current = await _weatherProvider.fetchCurrentWeather(cityName);

    await clearCache(cityName);
    createWeatherCache(current.weather[0], cityName, current.dateTime);

    for (final item in response.list) {
      for (final weather in item.weather) {
        createWeatherCache(weather, cityName, item.dateTime);
      }
    }
  }

  Future createWeatherCache(
      WeatherResponse weather, String cityName, DateTime dateTime) async {
      final entity = WeatherEntity(
        city: cityName,
        dateTime: dateTime,
        main: weather.main,
      );

      await _weatherRepository.save(entity);
      _cachedWeathers.add(entity);
      notifyListeners();
  }

  Future clearCache(String cityName) async {
    await _weatherRepository.clear(cityName);
  }
}