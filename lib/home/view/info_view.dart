import 'package:flutter/material.dart';
import 'package:ms_kopalisce_main/home/home.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const OpenTime(),
            const SizedBox(height: 10),
            const AdditionalInfo(),
          ],
        ),
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}
