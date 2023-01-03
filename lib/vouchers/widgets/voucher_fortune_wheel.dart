import 'dart:async';

import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:ms_kopalisce_main/authentication/authentication.dart';

import '../vouchers.dart';

class VoucherFortuneWheel extends StatefulWidget {
  const VoucherFortuneWheel._({Key? key}) : super(key: key);

  static Widget provider(BuildContext context, {required List<Voucher> vouchers}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FortuneWheelCubit(vouchers: vouchers),
        ),
        BlocProvider(
          create: (context) => FortuneWheelWinnerPickerBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            couponRepository: RepositoryProvider.of<CouponRepository>(context),
            vouchers: vouchers,
          ),
        ),
      ],
      child: const VoucherFortuneWheel._(),
    );
  }

  @override
  State<VoucherFortuneWheel> createState() => _VoucherFortuneWheelState();
}

class _VoucherFortuneWheelState extends State<VoucherFortuneWheel> {
  late StreamController<int> controller;
  late StreamSubscription<int> streamSubscription;

  @override
  void initState() {
    super.initState();
    controller = StreamController<int>.broadcast();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      controller.add(
        BlocProvider.of<FortuneWheelCubit>(context).state.roll(),
      );
    });

    streamSubscription = controller.stream.listen((index) {
      BlocProvider.of<FortuneWheelCubit>(context).selectedIndexUpdated(index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
    controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<FortuneWheelCubit, FortuneWheelState>(
          listener: (context, state) {
            if (state.status == FortuneWheelStatus.spinning) {
              BlocProvider.of<FortuneWheelWinnerPickerBloc>(context).add(FortuneWheelWinnerPicked(state.selectedIndex));
            }
          },
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
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
