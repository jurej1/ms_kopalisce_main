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
    return ListView.separated(
      shrinkWrap: true,
      itemCount: TicketType.values.length,
      itemBuilder: (context, index) {
        final sortedTickets = _servicesLoadSuccess.sortByType(TicketType.values[index]);
        return BathroomServicesList(tickets: sortedTickets);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
