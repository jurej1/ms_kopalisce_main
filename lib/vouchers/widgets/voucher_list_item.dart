import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ms_kopalisce_main/vouchers/view/view.dart';

class VoucherListItem extends StatelessWidget {
  const VoucherListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final VoucherUser item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 45,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              item.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 12.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.discountAmount} ${item.unit.toDisplayString()} OFF',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text('Velja do: ${DateFormat('dd.MM.yyyy').format(item.expiresOn)}'),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(VoucherQrCodeView.route(context, item));
                  },
                  child: const Text(
                    'QR',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.5),
        ],
      ),
    );
  }
}
