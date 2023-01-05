import 'package:bloc/bloc.dart';

class QuizAnswerRecordCubit extends Cubit<List<bool>> {
  QuizAnswerRecordCubit() : super([]);

  anwserAdded(bool anwser) {
    final stateList = List<bool>.from(state);

    emit(stateList..add(anwser));
  }
}
