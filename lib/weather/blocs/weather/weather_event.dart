part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class LoadWeatherDataRequested extends WeatherEvent {
  const LoadWeatherDataRequested();

  @override
  List<Object> get props => [];
}
