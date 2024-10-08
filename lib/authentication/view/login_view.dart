import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ms_kopalisce_main/authentication/view/auth_view.dart';

import '../authentication.dart';
import '../widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView() : super();
  static MaterialPageRoute route(BuildContext context) {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider<LoginFormBloc>(
        create: (context) => LoginFormBloc(authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)),
        child: const LoginView(),
      );
    });
  }

  static Widget provider(BuildContext context) {
    return BlocProvider<LoginFormBloc>(
      create: (context) => LoginFormBloc(authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)),
      child: const LoginView(),
    );
  }

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        BlocProvider.of<LoginFormBloc>(context).add(LoginEmailUnfocused());
        FocusScope.of(context).requestFocus(passwordFocusNode);
      }
    });

    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        BlocProvider.of<LoginFormBloc>(context).add(LoginPasswordUnfocused());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          // showInfoAuthFlushbar(context, title: state.errorMsg);
        }
      },
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Image.asset(
                  'assets/sobota_svica.png',
                  height: size.height * 0.3,
                ),
                _EmailInputField(focusNode: emailFocusNode),
                const SizedBox(height: 25),
                _PasswordInputField(focusNode: passwordFocusNode),
                const SizedBox(height: 25),
                _SubmitButton(),
                const SizedBox(height: 25),
                SwitchViewButton(
                  title: 'Nimate še računa? Registracija',
                  onPressed: () {
                    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
                    // Navigator.of(context).pushReplacement(RegisterView.route(context));
                    BlocProvider.of<AuthViewCubit>(context).updateView(AuthViewState.register);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInputField extends StatelessWidget {
  final FocusNode focusNode;

  const _EmailInputField({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return InputField(
          preffixIcon: Icon(
            Icons.email,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: state.email.error == null
              ? const Icon(
                  Icons.check_rounded,
                  color: Colors.green,
                )
              : null,
          keyboardType: TextInputType.emailAddress,
          action: TextInputAction.next,
          focusNode: focusNode,
          onChanged: (val) => BlocProvider.of<LoginFormBloc>(context).add(LoginEmailChanged(val)),
          hintText: 'Email',
          errorText: state.email.invalid ? 'Please enter a valid email' : null,
        );
      },
    );
  }
}

class _PasswordInputField extends StatelessWidget {
  final FocusNode focusNode;

  const _PasswordInputField({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return InputField(
          preffixIcon: Icon(
            Icons.vpn_key,
            color: Theme.of(context).primaryColor,
          ),
          keyboardType: TextInputType.visiblePassword,
          focusNode: focusNode,
          action: TextInputAction.done,
          hintText: 'Geslo',
          obscure: true,
          errorText: state.password.invalid ? 'Please enter a valid password' : null,
          onChanged: (val) => BlocProvider.of<LoginFormBloc>(context).add(LoginPasswordChanged(val)),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SubmitButton(
          title: 'Vpiši se',
          isLoading: state.status.isSubmissionInProgress,
          onPressed: () {
            if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
            BlocProvider.of<LoginFormBloc>(context).add(LoginFormSubmit());
          },
        );
      },
    );
  }
}
