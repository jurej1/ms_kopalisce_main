import 'package:flutter/material.dart';

class AdditionalInfoDisplayer extends StatelessWidget {
  const AdditionalInfoDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dodatne Informacije',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          'Zaenkrat ni nobenih dodatnih informacij',
        ),
      ],
    );
  }
}
