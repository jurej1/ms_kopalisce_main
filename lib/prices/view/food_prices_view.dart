import 'package:flutter/material.dart';

class FoodPricesView extends StatelessWidget {
  const FoodPricesView({Key? key}) : super(key: key);

  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) {
        return const FoodPricesView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
