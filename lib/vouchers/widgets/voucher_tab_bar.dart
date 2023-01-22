import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class VoucherTabBar extends StatelessWidget {
  const VoucherTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: 35,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Material(
          elevation: 3,
          color: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: BlocBuilder<VoucherViewSelectorCubit, VoucherStatus>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Transform.scale(
                    scale: state == VoucherStatus.valid ? 1.1 : 0.95,
                    child: TextButton(
                      child: const Text(
                        'Na Vojo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<VoucherViewSelectorCubit>(context).viewChanged(VoucherStatus.valid);
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: state == VoucherStatus.used ? 1.1 : 0.95,
                    child: TextButton(
                      child: const Text(
                        'Uporabljeni',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<VoucherViewSelectorCubit>(context).viewChanged(VoucherStatus.used);
                      },
                    ),
                  ),
                  Transform.scale(
                    scale: state == VoucherStatus.expired ? 1.1 : 0.95,
                    child: TextButton(
                      child: const Text(
                        'Potečeni',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<VoucherViewSelectorCubit>(context).viewChanged(VoucherStatus.expired);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
