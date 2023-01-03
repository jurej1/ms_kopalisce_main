import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_repository/src/models/models.dart';

class WeatherRepository {
  const WeatherRepository();
  Future<WeatherLocation?> getCurrentData(String city) async {
    http.Response response = await http.get(
      Uri.parse('http://api.weatherapi.com/v1/current.json?key=ea067f30db724e109b1152258223112&q=${city}&aqi=no'),
    );

    if (response.statusCode == 200) {
      return WeatherLocation.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
