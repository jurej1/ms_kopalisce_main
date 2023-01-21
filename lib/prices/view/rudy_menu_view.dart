import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:price_repository/price_repository.dart';

import '../../home/home.dart';
import 'view.dart';

class RudyMneuView extends StatelessWidget {
  const RudyMneuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          children: [
            _FoodItemTicker(
              key: UniqueKey(),
              item: RudyRepository.friskoDomaceItem,
            ),
            _ImageDisplayer(path: RudyRepository.friskoDomace),
            const _LineSeparator(),
            _FoodItemTicker(
              key: UniqueKey(),
              item: RudyRepository.rudijevaBombetkaItem,
            ),
            _ImageDisplayer(path: RudyRepository.rudijevaBombetka),
            const _LineSeparator(),
            const _OtherSelection(),
            _ImageDisplayer(path: RudyRepository.ostalaPonudba),
            const _LineSeparator(),
            const _OtherPricesMenu(),
          ],
        ),
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}

class _FoodItemTicker extends StatelessWidget {
  const _FoodItemTicker({
    Key? key,
    required this.item,
  }) : super(key: key);

  final FoodItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
        const SizedBox(height: 10),
        Text(item.description ?? ''),
      ],
    );
  }
}

class _LineSeparator extends StatelessWidget {
  const _LineSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 2,
      color: Colors.blue,
    );
  }
}

class _OtherSelection extends StatelessWidget {
  const _OtherSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ostala ponudba',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
        const SizedBox(height: 10),
        ...RudyRepository.ostalaPonudbaItem.map((e) => _ticket(e)).toList()
      ],
    );
  }

  Widget _ticket(FoodItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Text(item.description ?? ''),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _OtherPricesMenu extends StatelessWidget {
  const _OtherPricesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.padded,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(BathroomServicesView.route(context));
          },
          child: const Text('Cenik kart'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.padded,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(FoodPricesView.route(context));
          },
          child: const Text('Cenik ostale Hrane\n in pijace'),
        ),
      ],
    );
  }
}

class _ImageDisplayer extends StatefulWidget {
  const _ImageDisplayer({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  State<_ImageDisplayer> createState() => _ImageDisplayerState();
}

class _ImageDisplayerState extends State<_ImageDisplayer> {
  late Image image;

  @override
  void initState() {
    super.initState();

    image = Image.asset(
      widget.path,
      package: 'price_repository',
      scale: 0.95,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return image;
  }
}
