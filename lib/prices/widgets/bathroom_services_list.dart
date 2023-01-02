import 'package:flutter/material.dart';
import 'package:price_repository/price_repository.dart';

class BathroomServicesList extends StatelessWidget {
  const BathroomServicesList({
    Key? key,
    required this.tickets,
    required this.title,
  }) : super(key: key);

  final List<Ticket> tickets;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            );
          }
          final item = tickets[index - 1];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.title),
              Text('\$${item.price}'),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
        itemCount: tickets.length + 1);
  }
}
