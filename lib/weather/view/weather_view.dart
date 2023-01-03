import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/home/home.dart';

import '../weather.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherStateSuccess) {
            return WeatherDisplayer(weatherLocation: state.location);
          } else if (state is WeatherStateLoading) {
            return const Center(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}
