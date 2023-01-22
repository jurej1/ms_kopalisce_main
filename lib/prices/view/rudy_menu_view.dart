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
            const _OtherPricesMenu(),
            const _LineSeparator(),
            _FoodItemTicket(
              key: UniqueKey(),
              item: RudyRepository.friskoDomaceItem,
            ),
            _ImageDisplayer(path: RudyRepository.friskoDomaceImagePath),
            const _LineSeparator(),
            _FoodItemTicket(
              key: UniqueKey(),
              item: RudyRepository.rudijevaBombetkaItem,
            ),
            _ImageDisplayer(path: RudyRepository.rudijevaBombetkaImagePath),
            const _LineSeparator(),
            const _OtherSelection(),
            _ImageDisplayer(path: RudyRepository.ostalaPonudbaImagePath),
          ],
        ),
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}

class _FoodItemTicket extends StatelessWidget {
  const _FoodItemTicket({
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
        Text(
          item.description ?? '',
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
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
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          item.description ?? '',
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _OtherPricesMenu extends StatelessWidget {
  const _OtherPricesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _GridButton(
          onPressed: () {
            Navigator.of(context).push(BathroomServicesView.route(context));
          },
          iconData: Icons.store,
          text: 'Karte',
        ),
        _GridButton(
          onPressed: () {
            Navigator.of(context).push(FoodPricesView.route(context));
          },
          iconData: Icons.food_bank_rounded,
          text: 'Ostalo',
        ),
        _GridButton(
          onPressed: () {
            Navigator.of(context).push(StoreView.route());
          },
          iconData: Icons.shop_two,
          text: 'Trgovina',
        )
      ],
    );
  }
}

class _GridButton extends StatelessWidget {
  const _GridButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.padded,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      onPrimary: Colors.white,
      primary: Colors.blue.shade300,
    );

    return ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          Text(text),
        ],
      ),
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
