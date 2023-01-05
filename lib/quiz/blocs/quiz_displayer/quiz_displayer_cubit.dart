import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_repository/quiz_repository.dart';

part 'quiz_displayer_state.dart';

class QuizDisplayerCubit extends Cubit<QuizDisplayerState> {
  QuizDisplayerCubit({
    required List<Question> questions,
  }) : super(
          QuizDisplayerState(
            question: questions,
            activeQuestionIndex: 0,
            status: QuizDisplayerStatus.pure,
          ),
        );

  void activeQuestionForward() {
    final maxIndex = state.question.length - 1;
    final nextIndex = state.activeQuestionIndex + 1;

    if (nextIndex < maxIndex) {
      emit(
        state.copyWith(
          activeQuestionIndex: nextIndex,
          status: QuizDisplayerStatus.playing,
        ),
      );
    } else {
      emit(
        state.copyWith(
          activeQuestionIndex: nextIndex,
          status: QuizDisplayerStatus.done,
        ),
      );
    }
  }
}
