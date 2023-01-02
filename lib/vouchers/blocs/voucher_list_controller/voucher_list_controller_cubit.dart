import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'voucher_list_controller_state.dart';

class VoucherListControllerCubit extends Cubit<VoucherListControllerState> {
  VoucherListControllerCubit() : super(VoucherListControllerInitial());
}
