class WeatherResponse {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherResponse(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory WeatherResponse.fromMap(Map<String, dynamic> map) {
    return WeatherResponse(
        id: map["id"],
        main: map["main"],
        description: map["description"],
        icon: map["icon"]);
  }
}
