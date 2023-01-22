import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../vouchers/vouchers.dart';
import '../quiz.dart';

class QuizCompletedDisplayer extends StatelessWidget {
  const QuizCompletedDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Kviz opravljen :)'),
        BlocBuilder<QuizAnswerRecordCubit, List<bool>>(
          builder: (context, state) {
            final nrRight = state.where((element) => element).toList().length;
            return Text('Pravilno: $nrRight / ${state.length}');
          },
        ),
        const SizedBox(height: 20),
        const _RewardDisplayer(),
      ],
    );
  }
}

class _RewardDisplayer extends StatelessWidget {
  const _RewardDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.6;
    return BlocConsumer<QuizRewardBloc, QuizRewardState>(
      listener: (context, state) {
        if (state is QuizRewardSuccess) {
          BlocProvider.of<VoucherValidListBloc>(context).add(
            VouchersListItemAddedToList(state.value),
          );
        }
      },
      builder: (context, state) {
        if (state is QuizRewardLoading) {
          return const LinearProgressIndicator();
        } else if (state is QuizRewardSuccess) {
          final voucher = state.value;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text('Česitamo zaslužili ste si naslednjo nagrado'),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              const Text('Kupon je bil že dodan v vašo zbirko'),
            ],
          );
        }
        return Container();
      },
    );
  }
}
