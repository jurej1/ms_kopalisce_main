part of 'register_form_bloc.dart';

class RegisterFormState extends Equatable {
  const RegisterFormState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.errorMsg,
  });

  final FormzStatus status;
  final Email email;
  final Password password;
  final String? errorMsg;

  @override
  List<Object?> get props => [status, email, password, errorMsg];

  RegisterFormState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    String? errorMsg,
  }) {
    return RegisterFormState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
