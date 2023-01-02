part of 'voucher_list_bloc.dart';

abstract class VoucherListState extends Equatable {
  const VoucherListState();

  @override
  List<Object> get props => [];
}

class VoucherListLoading extends VoucherListState {}

class VoucherListSucess extends VoucherListState {
  final List<VoucherUser> vouchers;
  final DocumentSnapshot? lastDocument;

  const VoucherListSucess({required this.vouchers, this.lastDocument});
}

class VoucherListEmpty extends VoucherListState {}

class VoucherListFail extends VoucherListState {}
