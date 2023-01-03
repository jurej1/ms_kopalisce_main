part of 'food_prices_list_bloc.dart';

abstract class FoodPricesListEvent extends Equatable {
  const FoodPricesListEvent();

  @override
  List<Object> get props => [];
}

class FoodPricesListLoadRequested extends FoodPricesListEvent {}
