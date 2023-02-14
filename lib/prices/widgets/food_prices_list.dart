import 'package:flutter/widgets.dart';
import 'package:price_repository/price_repository.dart';

import '../prices.dart';

class FoodPricesListBuilder extends StatelessWidget {
  const FoodPricesListBuilder({
    Key? key,
    required List<FoodItem> items,
  })  : _items = items,
        super(key: key);

  final List<FoodItem> _items;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        itemCount: FoodItemType.values.length,
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final type = FoodItemType.values[index];
          final sortedItems = sortByType(type);
          return FoodItemsList(
            title: type.toStringReadable(),
            sortedItems: sortedItems,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 20);
        },
      ),
    );
  }

  List<FoodItem> sortByType(FoodItemType type) {
    final elementsCopy = List<FoodItem>.from(_items);

    return elementsCopy.where((element) => element.type == type).toList()
      ..sort(
        (a, b) => a.price.compareTo(b.price),
      );
  }
}
