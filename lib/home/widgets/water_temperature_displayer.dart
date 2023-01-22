import 'package:flutter/material.dart';

class WaterTemperatureDisplayer extends StatelessWidget {
  const WaterTemperatureDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Temperatura vode',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        GridView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30,
            childAspectRatio: 1,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const _GridItem(
              degreeText: '23°C',
              poolText: 'Olimpijski',
            ),
            const _GridItem(
              degreeText: '27°C',
              poolText: 'Otroški',
            ),
            const _GridItem(
              degreeText: '25.5°C',
              poolText: 'Mali',
            )
          ],
        ),
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({Key? key, required this.degreeText, required this.poolText}) : super(key: key);

  final String degreeText;
  final String poolText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            degreeText,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 3),
          Text(
            poolText,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
