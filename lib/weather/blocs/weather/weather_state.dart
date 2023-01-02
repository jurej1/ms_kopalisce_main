part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  final WeatherLocation location;

  const WeatherStateSuccess(this.location);

  @override
  List<Object> get props => [location];
}

class WeatehrStateFail extends WeatherState {}
