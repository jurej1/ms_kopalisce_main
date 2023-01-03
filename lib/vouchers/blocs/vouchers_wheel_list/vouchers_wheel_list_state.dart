part of 'vouchers_wheel_list_bloc.dart';

abstract class VouchersWheelListState extends Equatable {
  const VouchersWheelListState();

  @override
  List<Object> get props => [];
}

class VouchersWheelListLoading extends VouchersWheelListState {}

class VouchersWheelListLoadSuccess extends VouchersWheelListState {
  final List<Voucher> vouchers;

  const VouchersWheelListLoadSuccess(this.vouchers);
}

class VouchersWheelListFail extends VouchersWheelListState {}
