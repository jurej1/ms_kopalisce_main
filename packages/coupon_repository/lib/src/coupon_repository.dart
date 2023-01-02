import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupon_repository/coupon_repository.dart';
import 'package:flutter/foundation.dart';

class CouponRepository {
  CouponRepository({FirebaseFirestore? firebaseFirestore}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  CollectionReference get _vouchersCollection => _firebaseFirestore.collection('vouchers');
  CollectionReference get _userVouchersCollection => _firebaseFirestore.collection('user_vouchers');

  Future<QuerySnapshot> loadVouchers({
    DocumentSnapshot? lastDoc,
    int limit = 12,
  }) async {
    Query query;
    if (lastDoc != null) {
      query = _vouchersCollection.startAfterDocument(lastDoc).limit(limit);
    } else {
      query = _vouchersCollection.limit(limit);
    }

    return await query.get();
  }

  Future<QuerySnapshot> loadUserVouchers({
    DocumentSnapshot? lastDoc,
    required String uid,
    int limit = 12,
  }) async {
    Query query;
    if (lastDoc != null) {
      query = _userVouchersCollection.startAfterDocument(lastDoc).where('uid', isEqualTo: uid).limit(limit);
    } else {
      query = _userVouchersCollection.where('uid', isEqualTo: uid).limit(limit);
    }

    return await query.get();
  }

  Future<QuerySnapshot> loadUserVouchersByStatus({
    DocumentSnapshot? lastDoc,
    required String uid,
    int limit = 12,
    required VoucherStatus status,
  }) async {
    if (lastDoc == null) {
      if (status == VoucherStatus.valid) {
        return await _userVouchersCollection
            .where('uid', isEqualTo: uid)
            .where('status', isEqualTo: describeEnum(VoucherStatus.valid))
            .limit(limit)
            .get();
      } else if (status == VoucherStatus.used) {
        return await _userVouchersCollection
            .where('uid', isEqualTo: uid)
            .where('status', isEqualTo: describeEnum(VoucherStatus.used))
            .limit(limit)
            .get();
      } else {
        // status == VoucherStatus.expired
        return await _userVouchersCollection
            .where('uid', isEqualTo: uid)
            .where('status', isEqualTo: describeEnum(VoucherStatus.expired))
            .limit(limit)
            .get();
      }
    } else {
      if (status == VoucherStatus.valid) {
        return await _userVouchersCollection
            .where('uid', isEqualTo: uid)
            .where('status', isEqualTo: describeEnum(VoucherStatus.valid))
            .limit(limit)
            .startAfterDocument(lastDoc)
            .get();
      } else if (status == VoucherStatus.used) {
        return await _userVouchersCollection
            .where('uid', isEqualTo: uid)
            .where('status', isEqualTo: describeEnum(VoucherStatus.used))
            .limit(limit)
            .startAfterDocument(lastDoc)
            .get();
      } else {
        // status == VoucherStatus.expired
        return await _userVouchersCollection
            .where('uid', isEqualTo: uid)
            .where('status', isEqualTo: describeEnum(VoucherStatus.expired))
            .limit(limit)
            .startAfterDocument(lastDoc)
            .get();
      }
    }
  }
}
