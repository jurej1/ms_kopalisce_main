import 'package:flutter/material.dart';
import 'package:price_repository/price_repository.dart';

class BathroomServicesList extends StatelessWidget {
  const BathroomServicesList({
    Key? key,
    required this.tickets,
    this.title,
  }) : super(key: key);

  final List<Ticket> tickets;
  final String? title;

  int get _getListLength {
    if (title != null) {
      return tickets.length + 1;
    }
    return tickets.length;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0 && (title?.isNotEmpty ?? false)) {
          return Text(
            title!,
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
      itemCount: _getListLength,
    );
  }
}
