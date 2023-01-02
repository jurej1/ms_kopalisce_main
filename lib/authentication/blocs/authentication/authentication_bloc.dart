import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AuthenticationState.initial()) {
    _statusSubscription = _authenticationRepository.authenticationUser.listen(
      (authenticationUser) => add(
        _AuthenticationUserUpdated(authenticationUser),
      ),
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is _AuthenticationUserUpdated) {
      if (event.authenticationUser != null) {
        yield state.copyWith(status: AuthenticationStatus.authenticated, authUser: event.authenticationUser);
      } else if (event.authenticationUser == null) {
        yield state.copyWith(status: AuthenticationStatus.unauthenticated, authUser: event.authenticationUser);
      }
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  final AuthenticationRepository _authenticationRepository;

  late final StreamSubscription _statusSubscription;

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }

  @override
  void onTransition(Transition<AuthenticationEvent, AuthenticationState> transition) {
    super.onTransition(transition);
    log(transition.toString());
  }
}
