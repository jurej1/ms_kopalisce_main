import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:price_repository/price_repository.dart';

part 'food_prices_list_event.dart';
part 'food_prices_list_state.dart';

class FoodPricesListBloc extends Bloc<FoodPricesListEvent, FoodPricesListState> {
  FoodPricesListBloc({
    required PriceRepository priceRepository,
  })  : _priceRepository = priceRepository,
        super(FoodPricesListLoading());

  final PriceRepository _priceRepository;

  @override
  Stream<FoodPricesListState> mapEventToState(FoodPricesListEvent event) async* {
    if (event is FoodPricesListLoadRequested) {
      yield* _mapLoadRequestedToState();
    }
  }

  Stream<FoodPricesListState> _mapLoadRequestedToState() async* {
    yield FoodPricesListLoading();

    try {
      QuerySnapshot snapshot = await _priceRepository.loadFoodPrices();

      List<FoodItem> foodItems = snapshot.docs.map((e) => FoodItem.fromDocumentSnapshot(e)).toList();

      yield FoodPricesListLoadSucess(foodItems);
    } catch (e) {
      log(e.toString());
      yield FoodPricesListFail();
    }
  }
}
