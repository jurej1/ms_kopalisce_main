import 'package:flutter/material.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:intl/intl.dart';

class WeatherDisplayer extends StatelessWidget {
  const WeatherDisplayer({Key? key, required this.weatherLocation}) : super(key: key);

  final WeatherLocation weatherLocation;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(30),
      color: Colors.green,
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50 + 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weatherLocation.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              DateFormat('EEEE - d MMMM y').format(weatherLocation.lastUpdated),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              weatherLocation.tempC.toStringAsFixed(0) + '°',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Image(
                  image: AssetImage(
                    weatherLocation.iconPath,
                    package: 'weather_repository',
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  weatherLocation.conditionText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 1,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _AdditionalInfoDisplayer(
                  title: 'Wind',
                  units: 'km/h',
                  val: (weatherLocation.windKph) / 40,
                  value: weatherLocation.windKph.toStringAsFixed(0),
                ),
                _AdditionalInfoDisplayer(
                  title: 'Humidity',
                  units: '%',
                  val: (weatherLocation.humidity) / 100,
                  value: weatherLocation.humidity.toStringAsFixed(0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AdditionalInfoDisplayer extends StatelessWidget {
  const _AdditionalInfoDisplayer({
    Key? key,
    required this.title,
    required this.value,
    required this.units,
    required this.val,
  }) : super(key: key);

  final String title;
  final String value;
  final String units;
  final double val;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 27,
              letterSpacing: 0.5,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              units,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Container(
            width: size.width * 0.3,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: FractionallySizedBox(
              widthFactor: val,
              heightFactor: 1,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
