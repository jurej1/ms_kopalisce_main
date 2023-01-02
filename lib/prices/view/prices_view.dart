import 'package:flutter/material.dart';

import 'view.dart';

class PricesView extends StatelessWidget {
  const PricesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(BathroomServicesView.route(context));
            },
            child: const Text('Bathroom Services'),
          ),
        ],
      ),
    );
  }
}
