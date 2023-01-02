import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum VoucherUnit { money, percentage }

extension VoucherUnitX on VoucherUnit {
  String toJsonString() {
    return describeEnum(this);
  }

  static VoucherUnit fromJsonString(String value) {
    if (describeEnum(VoucherUnit.money) == value) {
      return VoucherUnit.money;
    } else {
      return VoucherUnit.percentage;
    }
  }
}

enum VoucherStatus { used, valid, expired }

extension VoucherStatusX on VoucherStatus {
  static VoucherStatus fromJsonString(String value) {
    if (describeEnum(VoucherStatus.valid) == value) {
      return VoucherStatus.valid;
    } else if (describeEnum(VoucherStatus.expired) == value) {
      return VoucherStatus.expired;
    } else {
      return VoucherStatus.used;
    }
  }
}

abstract class VoucherX extends Equatable {
  final String id;
  final String voucherNumber;
  final String name;
  final String description;
  final int discountAmount;
  final VoucherUnit unit;

  const VoucherX({
    required this.id,
    required this.name,
    required this.description,
    required this.discountAmount,
    required this.unit,
    required this.voucherNumber,
  });

  @override
  List<Object> get props {
    return [
      id,
      voucherNumber,
      name,
      description,
      discountAmount,
      unit,
    ];
  }
}

class Voucher extends VoucherX {
  const Voucher({
    required super.id,
    required super.name,
    required super.description,
    required super.discountAmount,
    required super.unit,
    required super.voucherNumber,
  });

  Voucher copyWith({
    String? description,
    int? discountAmount,
    String? id,
    String? name,
    VoucherUnit? unit,
    String? voucher_number,
  }) {
    return Voucher(
      description: description ?? this.description,
      discountAmount: discountAmount ?? this.discountAmount,
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      voucherNumber: voucher_number ?? this.voucherNumber,
    );
  }

  factory Voucher.fromDocumentSnapshot(DocumentSnapshot snap) {
    Map<dynamic, dynamic>? data = snap.data() as Map<dynamic, dynamic>;

    return Voucher(
      id: snap.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      discountAmount: data['discountAmount'] ?? 0,
      unit: VoucherUnitX.fromJsonString(snap['unit']),
      voucherNumber: data['voucherNumber'],
    );
  }
}

class VoucherUser extends VoucherX {
  final String uid;
  final DateTime expiresOn;
  final VoucherStatus status;

  VoucherUser({
    required this.uid,
    required this.expiresOn,
    required this.status,
    required super.id,
    required super.name,
    required super.description,
    required super.discountAmount,
    required super.unit,
    required super.voucherNumber,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      discountAmount,
      unit,
      voucherNumber,
      expiresOn,
      status,
      uid,
    ];
  }

  factory VoucherUser.fromDocumentSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<dynamic, dynamic>;
    return VoucherUser(
      uid: data['uid'],
      expiresOn: (data['expiresOn'] as Timestamp).toDate(),
      status: VoucherStatusX.fromJsonString(data['status']),
      id: snap.id,
      name: data['name'],
      description: data['description'],
      discountAmount: data['discountAmount'],
      unit: VoucherUnitX.fromJsonString(data['unit']),
      voucherNumber: data['voucherNumber'],
    );
  }

  VoucherUser copyWith({
    String? uid,
    DateTime? expiresOn,
    VoucherStatus? status,
    String? description,
    int? discountAmount,
    String? id,
    String? name,
    VoucherUnit? unit,
    String? voucher_number,
  }) {
    return VoucherUser(
      uid: uid ?? this.uid,
      expiresOn: expiresOn ?? this.expiresOn,
      status: status ?? this.status,
      description: description ?? this.description,
      discountAmount: discountAmount ?? this.discountAmount,
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      voucherNumber: voucher_number ?? this.voucherNumber,
    );
  }
}
