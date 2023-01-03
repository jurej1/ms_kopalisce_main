import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../vouchers.dart';

class VoucherWheelView extends StatelessWidget {
  const VoucherWheelView({Key? key}) : super(key: key);

  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(
      builder: ((context) {
        return BlocProvider(
          create: (context) => VouchersWheelListBloc(
            couponRepository: RepositoryProvider.of<CouponRepository>(context),
          )..add(VouchersWheelListLoadRequested()),
          child: const VoucherWheelView(),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VoucherWheelView'),
      ),
      body: BlocBuilder<VouchersWheelListBloc, VouchersWheelListState>(
        builder: (context, state) {
          if (state is VouchersWheelListLoadSuccess) {
            return VoucherFortuneWheel.provider(context, vouchers: state.vouchers);
          } else if (state is VouchersWheelListLoading) {
            return const _LoadingScreen();
          } else if (state is VouchersWheelListFail) {
            return const _ErrorScreen();
          }

          return Container();
        },
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Sorry there was an error'),
    );
  }
}
