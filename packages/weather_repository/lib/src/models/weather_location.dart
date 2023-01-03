import 'package:equatable/equatable.dart';

class WeatherLocation extends Equatable {
  final String name;
  final DateTime lastUpdated;
  final double tempC;
  final double windKph;
  final int humidity;
  final String conditionText;
  final String iconPath;

  WeatherLocation({
    required this.name,
    required this.lastUpdated,
    required this.tempC,
    required this.windKph,
    required this.humidity,
    required this.conditionText,
    required this.iconPath,
  });

  @override
  List<Object> get props {
    return [
      name,
      lastUpdated,
      tempC,
      windKph,
      humidity,
      conditionText,
      iconPath,
    ];
  }

  WeatherLocation copyWith({
    String? name,
    DateTime? lastUpdated,
    double? tempC,
    double? windKmh,
    int? hummidity,
    String? conditionText,
    String? iconPath,
  }) {
    return WeatherLocation(
      name: name ?? this.name,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      tempC: tempC ?? this.tempC,
      windKph: windKmh ?? this.windKph,
      humidity: hummidity ?? this.humidity,
      conditionText: conditionText ?? this.conditionText,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  static WeatherLocation fromJson(Map<String, dynamic> data) {
    String iconPathSource = data['current']['condition']['icon'];

    String iconFileNumber = iconPathSource.substring(iconPathSource.length - 7);

    if (iconPathSource.contains('day')) {
      iconFileNumber = 'lib/assets/day/' + iconFileNumber;
    } else {
      iconFileNumber = 'lib/assets/night/' + iconFileNumber;
    }
    return WeatherLocation(
      name: data['location']['name'],
      lastUpdated: data['current']['last_updated'],
      tempC: data['current']['temp_c'],
      windKph: data['current']['wind_kph'],
      humidity: data['current']['humidity'],
      conditionText: data['current']['condition']['text'],
      iconPath: iconFileNumber,
    );
  }
}
