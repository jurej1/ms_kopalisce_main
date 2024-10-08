import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../functions/functions.dart';
import '../../models/models.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  RegisterFormBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const RegisterFormState());

  @override
  Stream<RegisterFormState> mapEventToState(
    RegisterFormEvent event,
  ) async* {
    if (event is RegisterEmailChanged) {
      yield _mapEmailChangedToState(event);
    } else if (event is RegisterEmailUnfocused) {
      yield _mapEmailUnfocusedToState();
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event);
    } else if (event is RegisterPasswordUnfocused) {
      yield _mapPasswordUnfocusedToState();
    } else if (event is RegisterFormSubmit) {
      yield* _mapFormSubmittedToState();
    }
  }

  final AuthenticationRepository _authenticationRepository;

  RegisterFormState _mapEmailChangedToState(RegisterEmailChanged event) {
    final email = Email.dirty(event.value);

    return state.copyWith(
      email: email.invalid ? Email.pure(event.value) : email,
      status: Formz.validate([email, state.password]),
    );
  }

  RegisterFormState _mapEmailUnfocusedToState() {
    final email = Email.dirty(state.email.value);

    return state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    );
  }

  RegisterFormState _mapPasswordChangedToState(RegisterPasswordChanged event) {
    final password = Password.dirty(event.value);

    return state.copyWith(
      password: password.invalid ? Password.pure(event.value) : password,
      status: Formz.validate([password, state.email]),
    );
  }

  RegisterFormState _mapPasswordUnfocusedToState() {
    final password = Password.dirty(state.password.value);

    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    );
  }

  Stream<RegisterFormState> _mapFormSubmittedToState() async* {
    final password = Password.dirty(state.password.value);
    final email = Email.dirty(state.email.value);
    yield state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([password, email]),
    );

    if (state.status.isValidated) {
      try {
        yield (state.copyWith(status: FormzStatus.submissionInProgress));

        await _authenticationRepository.createUserWithEmailAndPassword(email: state.email.value, password: state.password.value);

        yield (state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        yield (state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMsg: authExceptionToString(e.toString()),
        ));
      }
    }
  }
}
