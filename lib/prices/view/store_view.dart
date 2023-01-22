import 'package:flutter/material.dart';
import 'package:ms_kopalisce_main/app.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);

  static route() {
    return MaterialPageRoute(
      builder: (context) {
        return const StoreView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rudijeva trgovina'),
      ),
    );
  }
}
