import 'package:flutter/material.dart';
import 'package:ms_kopalisce_main/weather/weather.dart';
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
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(weatherLocation.imagePath, package: 'weather_repository'),
          )

          // color: Colors.green,
          ),
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
            _WeatherConditionDisplayer(weatherLocation: weatherLocation),
            const SizedBox(height: 10),
            const _Separator(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalWeatherInfo(
                  title: 'Wind',
                  units: 'km/h',
                  val: (weatherLocation.windKph) / 40,
                  value: weatherLocation.windKph.toStringAsFixed(0),
                ),
                AdditionalWeatherInfo(
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

class _WeatherConditionDisplayer extends StatelessWidget {
  const _WeatherConditionDisplayer({
    Key? key,
    required this.weatherLocation,
  }) : super(key: key);

  final WeatherLocation weatherLocation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Image(
            image: AssetImage(
              weatherLocation.iconPath,
              package: 'weather_repository',
            ),
            errorBuilder: (context, _, __) {
              return Container();
            },
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
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
