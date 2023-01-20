import 'package:bloc/bloc.dart';

enum AuthViewState { login, register }

class AuthViewCubit extends Cubit<AuthViewState> {
  AuthViewCubit() : super(AuthViewState.login);

  void updateView(AuthViewState newView) {
    emit(newView);
  }
}
