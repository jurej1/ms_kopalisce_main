import 'package:flutter/material.dart';

class VoucherWheelView extends StatelessWidget {
  const VoucherWheelView({Key? key}) : super(key: key);

  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: ((context) {
        return const VoucherWheelView();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VoucherWheelView'),
      ),
    );
  }
}
