import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum HomeViewSelectorState { home, weather, coupons, prices, quiz }

extension HomeViewSelectorStateX on HomeViewSelectorState {
  bool get isHome => this == HomeViewSelectorState.home;
  bool get isWeather => this == HomeViewSelectorState.weather;
  bool get isCoupons => this == HomeViewSelectorState.coupons;
  bool get isPrices => this == HomeViewSelectorState.prices;
  bool get isQuiz => this == HomeViewSelectorState.quiz;

  IconData mapStateToIcon() {
    if (isHome) {
      return Icons.home;
    } else if (isWeather) {
      return Icons.cloud;
    } else if (isCoupons) {
      return Icons.discount;
    } else if (isPrices) {
      return Icons.price_change;
    } else if (isQuiz) {
      return Icons.question_answer;
    }

    return Icons.check;
  }
}

class HomeViewSelectorCubit extends Cubit<HomeViewSelectorState> {
  HomeViewSelectorCubit() : super(HomeViewSelectorState.home);

  void valueUpdatedEnum(HomeViewSelectorState val) {
    emit(val);
  }

  void valuUpdatedIndex(int index) {
    emit(HomeViewSelectorState.values.elementAt(index));
  }
}
