import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherRepository {
  const WeatherRepository();
  Future<void> getCurrentData(String city) async {
    http.Response response = await http.get(
      Uri.parse('http://api.weatherapi.com/v1/current.json?key=ea067f30db724e109b1152258223112&q=${city}&aqi=no'),
    );

    // jsonDecode(response.body);
  }
}
