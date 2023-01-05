import 'package:bloc/bloc.dart';

class QuizAnwserRecordCubit extends Cubit<List<bool>> {
  QuizAnwserRecordCubit() : super([]);

  anwserAdded(bool anwser) {
    final stateList = List<bool>.from(state);

    emit(stateList..add(anwser));
  }
}
