import 'package:flutter/material.dart';

import '../../home/home.dart';
import 'view.dart';

class PricesView extends StatelessWidget {
  const PricesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: const _Standard(),
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}

class _Standard extends StatelessWidget {
  const _Standard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(BathroomServicesView.route(context));
          },
          child: const Text('Bathroom Services'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(FoodPricesView.route(context));
          },
          child: const Text('Food Prices'),
        ),
      ],
    );
  }
}
