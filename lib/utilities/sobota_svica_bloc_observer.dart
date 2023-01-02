import 'package:flutter_bloc/flutter_bloc.dart';

class SobotaSvicaBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }
}
