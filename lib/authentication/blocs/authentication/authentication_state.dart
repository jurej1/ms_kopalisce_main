part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final AuthenticationUser? authUser;

  const AuthenticationState({
    required this.status,
    this.authUser,
  });

  factory AuthenticationState.initial() => const AuthenticationState(status: AuthenticationStatus.unknown);

  @override
  List<Object?> get props => [status, authUser];

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    AuthenticationUser? authUser,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      authUser: authUser ?? this.authUser,
    );
  }
}
