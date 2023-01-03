part of 'vouchers_wheel_list_bloc.dart';

abstract class VouchersWheelListEvent extends Equatable {
  const VouchersWheelListEvent();

  @override
  List<Object> get props => [];
}

class VouchersWheelListLoadRequested extends VouchersWheelListEvent {}
