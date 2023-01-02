import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_repository/src/models/weather_location.dart';

const String _apiKey = "ea067f30db724e109b1152258223112";
const String _weatherApiUrl = "http://api.weatherapi.com";

class WeatherRepository {
  const WeatherRepository() : super();

  Future<WeatherLocation?> getCurrentData(String city) async {
    http.Response response =
        await http.get(Uri.parse("http://api.weatherapi.com/v1/current.json?key=ea067f30db724e109b1152258223112&q=$city&aqi=no"));

    if (response.statusCode == 200) {
      return WeatherLocation.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
