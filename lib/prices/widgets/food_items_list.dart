import 'package:flutter/material.dart';
import 'package:price_repository/price_repository.dart';

class FoodItemsList extends StatelessWidget {
  const FoodItemsList({
    Key? key,
    required String title,
    required List<FoodItem> sortedItems,
  })  : _items = sortedItems,
        _title = title,
        super(key: key);

  final String _title;
  final List<FoodItem> _items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text(
            _title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          );
        }
        final item = _items[index - 1];

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.title),
            Text('€${item.price}'),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemCount: _items.length + 1,
    );
  }
}
