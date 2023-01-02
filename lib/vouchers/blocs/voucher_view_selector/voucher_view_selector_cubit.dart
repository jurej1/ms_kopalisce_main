import 'package:bloc/bloc.dart';
import 'package:coupon_repository/coupon_repository.dart';

class VoucherViewSelectorCubit extends Cubit<VoucherStatus> {
  VoucherViewSelectorCubit() : super(VoucherStatus.valid);

  void viewChanged(VoucherStatus newView) {
    emit(newView);
  }
}
