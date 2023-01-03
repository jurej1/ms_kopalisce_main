import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/home/home.dart';
import 'package:ms_kopalisce_main/prices/prices.dart';
import 'package:ms_kopalisce_main/quiz/quiz.dart';
import 'package:ms_kopalisce_main/vouchers/view/view.dart';
import 'package:ms_kopalisce_main/weather/view/view.dart';

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
          ],
          child: const HomeView._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewSelectorCubit, HomeViewSelectorState>(
      builder: (context, state) {
        if (state.isHome) {
          return const InfoView();
        } else if (state.isWeather) {
          return const WeatherView();
        } else if (state.isCoupons) {
          return VoucherViewList.providers();
        } else if (state.isPrices) {
          return const PricesView();
        } else if (state.isQuiz) {
          return const QuizeView();
        }
        return Container();
      },
    );
  }
}
