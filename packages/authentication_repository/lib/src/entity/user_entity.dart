import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final Timestamp? dateJoined;

  const UserEntity({
    required this.id,
    this.dateJoined,
  });

  @override
  List<Object?> get props => [id, dateJoined];

  UserEntity copyWith({
    String? id,
    Timestamp? dateJoined,
  }) {
    return UserEntity(
      id: id ?? this.id,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  static final empty = UserEntity(id: '');

  factory UserEntity.fromDocumentSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map?;
    if (data == null) return UserEntity.empty;

    return UserEntity(
      id: snap.id,
      dateJoined: data['dateJoined'],
    );
  }
}
