part of 'food_prices_list_bloc.dart';

abstract class FoodPricesListState extends Equatable {
  const FoodPricesListState();

  @override
  List<Object> get props => [];
}

class FoodPricesListLoading extends FoodPricesListState {}

class FoodPricesListLoadSucess extends FoodPricesListState {
  final List<FoodItem> items;

  const FoodPricesListLoadSucess(this.items);
}

class FoodPricesListFail extends FoodPricesListState {}
