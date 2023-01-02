import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/home/home.dart';
import 'package:ms_kopalisce_main/prices/prices.dart';
import 'package:ms_kopalisce_main/vouchers/view/view.dart';
import 'package:ms_kopalisce_main/weather/blocs/weather/weather_bloc.dart';
import 'package:ms_kopalisce_main/weather/view/view.dart';
import 'package:weather_repository/weather_repository.dart';

class HomeView extends StatelessWidget {
  const HomeView._({Key? key}) : super(key: key);

  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeViewSelectorCubit(),
            ),
            BlocProvider(
              create: (context) =>
                  WeatherBloc(weatherRepository: RepositoryProvider.of<WeatherRepository>(context))..add(const LoadWeatherDataRequested()),
            )
          ],
          child: const HomeView._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeViewSelectorCubit, HomeViewSelectorState>(
        builder: (context, state) {
          if (state.isHome) {
            return const InfoView();
          } else if (state.isWeather) {
            return const WeatherView();
          } else if (state.isCoupons) {
            return VoucherViewList.providers();
          } else if (state.isPrices) {
            return const PricesView();
          }
          return Container();
        },
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}
