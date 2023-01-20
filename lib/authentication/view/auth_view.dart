import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/authentication/authentication.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  static route() {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => AuthViewCubit(),
          child: const AuthView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthViewCubit, AuthViewState>(
      builder: (context, state) {
        if (state == AuthViewState.login) {
          return LoginView.provider(context);
        } else if (state == AuthViewState.register) {
          return RegisterView.provider(context);
        }
        return Container();
      },
    );
  }
}
