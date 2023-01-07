part of 'voucher_list_bloc.dart';

abstract class VoucherListEvent {
  const VoucherListEvent();
}

class VoucherListLoadRequested extends VoucherListEvent {}

class VoucherListLoadMoreRequested extends VoucherListEvent {}

class VouchersListItemAddedToList extends VoucherListEvent {
  final VoucherUser voucher;

  const VouchersListItemAddedToList(this.voucher);
}
