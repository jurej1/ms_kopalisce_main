import 'package:authentication_repository/src/entity/entity.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final DateTime? dateJoined;

  const User({
    required this.id,
    this.dateJoined,
  });

  @override
  List<Object?> get props => [id, dateJoined];

  User copyWith({
    String? id,
    DateTime? dateJoined,
  }) {
    return User(
      id: id ?? this.id,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  factory User.fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      dateJoined: entity.dateJoined?.toDate(),
    );
  }
}
