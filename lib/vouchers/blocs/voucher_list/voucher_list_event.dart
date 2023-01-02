part of 'voucher_list_bloc.dart';

abstract class VoucherListEvent extends Equatable {
  const VoucherListEvent();

  @override
  List<Object> get props => [];
}

class VoucherListLoadRequested extends VoucherListEvent {}

class VoucherListLoadMoreRequested extends VoucherListEvent {}
