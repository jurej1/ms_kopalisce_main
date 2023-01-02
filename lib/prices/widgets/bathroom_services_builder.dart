import 'package:flutter/material.dart';
import 'package:ms_kopalisce_main/prices/prices.dart';
import 'package:price_repository/price_repository.dart';

class BathroomServicesBuilder extends StatelessWidget {
  const BathroomServicesBuilder({
    Key? key,
    required BathroomServicesLoadSuccess loadSuccess,
  })  : _servicesLoadSuccess = loadSuccess,
        super(key: key);

  final BathroomServicesLoadSuccess _servicesLoadSuccess;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        itemCount: TicketType.values.length,
        itemBuilder: (context, index) {
          final type = TicketType.values[index];
          final sortedTickets = _servicesLoadSuccess.sortByType(type);
          return BathroomServicesList(
            title: type.toStringReadable(),
            tickets: sortedTickets,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 20);
        },
      ),
    );
  }
}
