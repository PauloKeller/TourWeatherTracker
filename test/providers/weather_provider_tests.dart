// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:tour_weather_tracker/src/dtos/dtos.dart';
import 'package:tour_weather_tracker/src/providers/providers.dart';

class MockDio extends Mock implements Dio {}

void main() {
  setUp(() {});

  group('Test weather provider', () {
    test('Test get current weather success', () async {
      final dio = MockDio();
      final sut = WeatherProvider(dio);

      final mock = {
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03n"
          }
        ],
      };

      when(dio.get(any)).thenAnswer((_) async => Response(data: mock, statusCode: 200));

      final response = await sut.getCurrentWeather();

      expect(response.weather.length, 1);

      final weather = response.weather[0];

      expect(weather.description, "scattered clouds");
      expect(weather.id, 802);
      expect(weather.main, "Clouds");
      expect(weather.icon, "03n");
    });

    test('Test get forecast success', () async {
      final dio = MockDio();
      final sut = WeatherProvider(dio);

      final mock = {
        "cod": "200",
        "message": 0,
        "cnt": 40,
        "list": [
          {
            "dt": 1661871600,
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10d"
              }
            ],
          },
          {
            "dt": 1661882400,
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10n"
              }
            ],
          },
          {
            "dt": 1661893200,
            "weather": [
              {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10n"
              }
            ],
          },
          {
            "dt": 1662292800,
            "weather": [
              {
                "id": 804,
                "main": "Clouds",
                "description": "overcast clouds",
                "icon": "04d"
              }
            ],
          }
        ],
      };

      when(dio.get(any)).thenAnswer((_) async => Response(data: mock, statusCode: 200));

      final response = await sut.getForecastWeather();

      expect(response.list.length, 4);

      final item = response.list[1];

      expect(item.dt.toIso8601String(), '2022-08-30T15:00:00.000');
      expect(item.weather.length, 1);
    });
  });
}
