import 'package:bloc/bloc.dart';
import 'package:coupon_repository/coupon_repository.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';

part 'fortune_wheel_state.dart';

class FortuneWheelCubit extends Cubit<FortuneWheelState> {
  FortuneWheelCubit({required List<Voucher> vouchers})
      : super(
          FortuneWheelState(items: vouchers),
        );

  void animationStarted() {
    emit(state.copyWith(status: FortuneWheelStatus.spinning));
  }

  void animationCompleted() {
    emit(state.copyWith(status: FortuneWheelStatus.done));
  }
}
