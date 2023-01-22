import 'package:flutter/material.dart';
import 'package:price_repository/price_repository.dart';

class StoreView extends StatelessWidget {
  StoreView({Key? key}) : super(key: key);

  static route() {
    return MaterialPageRoute(
      builder: (context) {
        return StoreView();
      },
    );
  }

  final List<StoreItem> items = RudyRepository.allStoreItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rudijeva trgovina'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return GridTile(
            key: ValueKey(item),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    item.imagesPaths.first,
                    package: 'price_repository',
                  ),
                ),
              ),
              child: Text(
                '${item.name} \n€ ${item.price}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
