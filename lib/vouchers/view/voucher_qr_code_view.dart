import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VoucherQrCodeView extends StatelessWidget {
  const VoucherQrCodeView({
    Key? key,
    required this.voucher,
  }) : super(key: key);

  final VoucherUser voucher;

  static route(BuildContext context, VoucherUser voucher) {
    return PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) {
        return VoucherQrCodeView(voucher: voucher);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final width = size.width * 0.6;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.4),
        body: Center(
          child: Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QrImage(
                  data: voucher.voucherNumber,
                  version: QrVersions.auto,
                  size: width * 0.5,
                ),
                const SizedBox(height: 10),
                Text(
                  '${voucher.discountAmount} ${voucher.unit.toDisplayString()} OFF',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(voucher.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
