import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class WeatherLocation extends Equatable {
  final String locationName;
  final double temp_c;
  final double temp_f;
  final DateTime lastUpdated;
  final double? wind_kph;
  final int? humidity;
  final String? condition;
  final String? iconPath;

  const WeatherLocation({
    required this.locationName,
    required this.temp_c,
    required this.temp_f,
    required this.lastUpdated,
    this.wind_kph,
    required this.humidity,
    this.condition,
    this.iconPath,
  });

  factory WeatherLocation.empty() => WeatherLocation(
        locationName: '',
        temp_c: 0.0,
        temp_f: 0.0,
        lastUpdated: DateTime.now(),
        wind_kph: 0.0,
        humidity: 0,
      );

  @override
  List<Object?> get props {
    return [
      locationName,
      temp_c,
      temp_f,
      lastUpdated,
      wind_kph,
      humidity,
      condition,
      iconPath,
    ];
  }

  WeatherLocation copyWith({
    String? locationName,
    double? temp_c,
    double? temp_f,
    DateTime? lastUpdated,
    double? wind_kph,
    int? humidity,
    String? condition,
    String? iconPath,
  }) {
    return WeatherLocation(
      locationName: locationName ?? this.locationName,
      temp_c: temp_c ?? this.temp_c,
      temp_f: temp_f ?? this.temp_f,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      wind_kph: wind_kph ?? this.wind_kph,
      humidity: humidity ?? this.humidity,
      condition: condition ?? this.condition,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    log(json.toString());

    final String rawIconPath = json['current']['condition']['icon'];

    final String pngNumber = rawIconPath.substring(rawIconPath.length - 7);

    String iconPath = '';

    if (rawIconPath.contains('day')) {
      iconPath = 'assets/day/$pngNumber';
    } else {
      iconPath = 'assets/night/$pngNumber';
    }

    return WeatherLocation(
      locationName: json['location']['name'],
      temp_c: json['current']['temp_c'],
      temp_f: json['current']['temp_f'],
      lastUpdated: DateTime.parse(json['current']['last_updated']),
      wind_kph: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
      condition: json['current']['condition']['text'],
      iconPath: iconPath,
    );
  }
}
