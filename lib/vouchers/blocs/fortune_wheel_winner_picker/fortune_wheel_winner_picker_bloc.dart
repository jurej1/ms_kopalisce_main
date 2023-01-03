import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupon_repository/coupon_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:ms_kopalisce_main/authentication/authentication.dart';

part 'fortune_wheel_winner_picker_event.dart';
part 'fortune_wheel_winner_picker_state.dart';

class FortuneWheelWinnerPickerBloc extends Bloc<FortuneWheelWinnerPickerEvent, FortuneWheelWinnerPickerState> {
  FortuneWheelWinnerPickerBloc({
    required List<Voucher> vouchers,
    required CouponRepository couponRepository,
    required AuthenticationBloc authenticationBloc,
  })  : _items = vouchers,
        _couponRepository = couponRepository,
        _authenticationBloc = authenticationBloc,
        super(FortuneWheelWinnerPickerInitial());

  final List<Voucher> _items;
  final CouponRepository _couponRepository;
  final AuthenticationBloc _authenticationBloc;

  @override
  Stream<FortuneWheelWinnerPickerState> mapEventToState(FortuneWheelWinnerPickerEvent event) async* {
    if (event is FortuneWheelWinnerPicked) {
      yield* _mapWinnerPickedToState(event);
    }
  }

  Stream<FortuneWheelWinnerPickerState> _mapWinnerPickedToState(FortuneWheelWinnerPicked event) async* {
    yield FortuneWheelWinnerPickerLoading();

    try {
      Voucher winnerItem = _items[event.index];

      VoucherUser userVoucher = VoucherUser(
        id: '',
        description: winnerItem.description,
        discountAmount: winnerItem.discountAmount,
        expiresOn: DateTime.now().add(const Duration(days: 20)),
        name: winnerItem.name,
        status: VoucherStatus.valid,
        uid: _authenticationBloc.state.authUser?.uid ?? '',
        unit: winnerItem.unit,
        voucherNumber: winnerItem.voucherNumber,
      );

      DocumentReference ref = await _couponRepository.addUserVoucher(userVoucher);

      userVoucher = userVoucher.copyWith(id: ref.id);

      yield FortuneWheelWinnerPickerLoadSuccess(userVoucher);
    } catch (e) {
      yield FortuneWheelWinnerPickerFailure();
    }
  }
}
