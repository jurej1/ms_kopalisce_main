import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupon_repository/coupon_repository.dart';
import 'package:ms_kopalisce_main/authentication/authentication.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'voucher_list_event.dart';
part 'voucher_list_state.dart';

abstract class VoucherListBloc extends Bloc<VoucherListEvent, VoucherListState> {
  VoucherListBloc({
    required CouponRepository couponRepository,
    required AuthenticationBloc authenticationBloc,
    required VoucherStatus loadByStatus,
  })  : _couponRepository = couponRepository,
        _authenticationBloc = authenticationBloc,
        _loadByStatus = loadByStatus,
        super(VoucherListLoading());

  final CouponRepository _couponRepository;
  final int _limit = 12;
  final AuthenticationBloc _authenticationBloc;
  final VoucherStatus _loadByStatus;

  @override
  Stream<VoucherListState> mapEventToState(VoucherListEvent event) async* {
    if (event is VoucherListLoadRequested) {
      yield* _mapLoadRequestedToState();
    } else if (event is VoucherListLoadMoreRequested) {
      yield* _mapLoadMoreRequestedToState();
    } else if (event is VouchersListItemAddedToList) {
      yield* _mapItemAddedToState(event);
    }
  }

  Stream<VoucherListState> _mapLoadRequestedToState() async* {
    if (_authenticationBloc.state.status.isAuthenticated) {
      yield VoucherListLoading();

      try {
        QuerySnapshot querySnapshot = await _couponRepository.loadUserVouchersByStatus(
          uid: _authenticationBloc.state.authUser!.uid!,
          status: _loadByStatus,
          limit: _limit,
        );
        List<VoucherUser> listData = querySnapshot.docs
            .map(
              (e) => VoucherUser.fromDocumentSnapshot(e),
            )
            .toList();

        if (listData.isEmpty) {
          yield const VoucherListSucess(hasReachedMax: true, vouchers: []);
        } else {
          List<VoucherUser> invalidItems = listData.where((element) => element.isExpired()).toList();
          List<VoucherUser> validItems = listData.where((element) => !element.isExpired()).toList();

          if (invalidItems.isNotEmpty) {
            List<VoucherUser> updatedInvalidItems = invalidItems.map((e) => e.copyWith(status: VoucherStatus.expired)).toList();

            await _couponRepository.updateUserVoucher(updatedInvalidItems.first);
          }

          yield VoucherListSucess(
            vouchers: validItems,
            lastDocument: querySnapshot.docs.last,
            hasReachedMax: listData.length < _limit,
          );
        }
      } catch (e) {
        log(e.toString());
        yield VoucherListFail();
      }
    } else {
      yield VoucherListFail();
    }
  }

  Stream<VoucherListState> _mapLoadMoreRequestedToState() async* {
    if (state is VoucherListSucess && !(state as VoucherListSucess).hasReachedMax) {
      final currentState = (state as VoucherListSucess);
      List<VoucherUser> vouchers = currentState.vouchers;

      try {
        QuerySnapshot querySnapshot = await _couponRepository.loadUserVouchersByStatus(
          uid: _authenticationBloc.state.authUser!.uid!,
          status: _loadByStatus,
          lastDoc: currentState.lastDocument,
          limit: _limit,
        );
        List<VoucherUser> listData = querySnapshot.docs
            .map(
              (e) => VoucherUser.fromDocumentSnapshot(e),
            )
            .toList();

        List<VoucherUser> invalidItems = listData.where((element) => element.isExpired()).toList();
        List<VoucherUser> validItems = listData.where((element) => !element.isExpired()).toList();

        if (invalidItems.isNotEmpty) {
          // invalidItems.map((e) => e.copyWith(status: VoucherStatus.expired)).toList().forEach((element) async {
          //   await _couponRepository.updateUserVoucher(element);
          // });
        }

        vouchers = vouchers + validItems;

        yield VoucherListSucess(
          vouchers: vouchers,
          lastDocument: querySnapshot.docs.last,
          hasReachedMax: querySnapshot.docs.length < _limit,
        );
      } catch (e) {
        yield VoucherListFail();
      }
    }
  }

  Stream<VoucherListState> _mapItemAddedToState(VouchersListItemAddedToList event) async* {
    if (state is VoucherListSucess) {
      final currentState = state as VoucherListSucess;
      final data = List<VoucherUser>.from(currentState.vouchers)..add(event.voucher);

      yield VoucherListSucess(
        vouchers: data,
        hasReachedMax: currentState.hasReachedMax,
        lastDocument: currentState.lastDocument,
      );
    }
  }
}

class VoucherValidListBloc extends VoucherListBloc {
  VoucherValidListBloc({
    required super.couponRepository,
    required super.authenticationBloc,
    super.loadByStatus = VoucherStatus.valid,
  });
}

class VoucherUsedListBloc extends VoucherListBloc {
  VoucherUsedListBloc({
    required super.couponRepository,
    required super.authenticationBloc,
    super.loadByStatus = VoucherStatus.used,
  });
}

class VoucherExpiredListBloc extends VoucherListBloc {
  VoucherExpiredListBloc({
    required super.couponRepository,
    required super.authenticationBloc,
    super.loadByStatus = VoucherStatus.expired,
  });
}
