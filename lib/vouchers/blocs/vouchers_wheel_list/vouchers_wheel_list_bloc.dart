import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupon_repository/coupon_repository.dart';
import 'package:equatable/equatable.dart';

part 'vouchers_wheel_list_event.dart';
part 'vouchers_wheel_list_state.dart';

class VouchersWheelListBloc extends Bloc<VouchersWheelListEvent, VouchersWheelListState> {
  VouchersWheelListBloc({
    required CouponRepository couponRepository,
  })  : _couponRepository = couponRepository,
        super(VouchersWheelListLoading());

  final CouponRepository _couponRepository;

  @override
  Stream<VouchersWheelListState> mapEventToState(VouchersWheelListEvent event) async* {
    if (event is VouchersWheelListLoadRequested) {
      yield* _mapLoadRequestedToState();
    }
  }

  Stream<VouchersWheelListState> _mapLoadRequestedToState() async* {
    yield VouchersWheelListLoading();

    try {
      QuerySnapshot snapshot = await _couponRepository.loadVouchersWheelCollection();

      List<Voucher> vouchers = snapshot.docs.map((e) => Voucher.fromDocumentSnapshot(e)).toList();

      yield VouchersWheelListLoadSuccess(vouchers);
    } catch (error) {
      yield VouchersWheelListFail();
    }
  }
}
