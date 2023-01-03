import 'package:flutter/material.dart';

import '../../home/home.dart';

class QuizeView extends StatelessWidget {
  const QuizeView({Key? key}) : super(key: key);

  static route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) {
        return const QuizeView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}
