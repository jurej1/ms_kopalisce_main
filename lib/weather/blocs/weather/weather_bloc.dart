import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(WeatherStateLoading());

  final WeatherRepository _weatherRepository;

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is LoadWeatherDataRequested) {
      yield* _mapDataRequestedToState(event);
    } else {
      yield WeatherStateLoading();
    }
  }

  Stream<WeatherState> _mapDataRequestedToState(LoadWeatherDataRequested event) async* {
    WeatherLocation? locationWeather = await _weatherRepository.getCurrentData('Murska Sobota');

    if (locationWeather != null) {
      yield WeatherStateSuccess(locationWeather);
    } else {
      yield WeatehrStateFail();
    }
  }
}
