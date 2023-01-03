import 'dart:async';

import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import '../vouchers.dart';

class VoucherFortuneWheel extends StatefulWidget {
  const VoucherFortuneWheel._({Key? key}) : super(key: key);

  static Widget provider(BuildContext context, {required List<Voucher> vouchers}) {
    return BlocProvider(
      create: (_) => FortuneWheelCubit(vouchers: vouchers),
      child: const VoucherFortuneWheel._(),
    );
  }

  @override
  State<VoucherFortuneWheel> createState() => _VoucherFortuneWheelState();
}

class _VoucherFortuneWheelState extends State<VoucherFortuneWheel> {
  late StreamController<int> controller;
  @override
  void initState() {
    super.initState();
    controller = StreamController<int>();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      controller.add(
        BlocProvider.of<FortuneWheelCubit>(context).state.roll(),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<FortuneWheelCubit, FortuneWheelState>(
          builder: (context, state) {
            return FortuneWheel(
                selected: controller.stream,
                animateFirst: false,
                onAnimationStart: () {
                  BlocProvider.of<FortuneWheelCubit>(context).animationStarted();
                },
                onAnimationEnd: () {
                  BlocProvider.of<FortuneWheelCubit>(context).animationCompleted();
                },
                physics: CircularPanPhysics(
                  duration: const Duration(seconds: 1),
                  curve: Curves.decelerate,
                ),
                indicators: const <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(
                      color: Colors.orange,
                    ),
                  ),
                ],
                items: state.items
                    .map(
                      (e) => FortuneItem(
                        child: Text(e.name),
                      ),
                    )
                    .toList());
          },
        ),
      ),
    );
  }
}
