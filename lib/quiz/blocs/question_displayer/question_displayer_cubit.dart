import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_repository/quiz_repository.dart';

part 'question_displayer_state.dart';

class QuestionDisplayerCubit extends Cubit<QuestionDisplayerState> {
  QuestionDisplayerCubit({
    required Question question,
  }) : super(
          QuestionDisplayerState(
            question: question,
            selectedAnwserIndex: null,
            status: QuestionDisplayerStatus.pure,
          ),
        );

  void anwserSelected(int index) {
    emit(
      state.copyWith(
        selectedAnwserIndex: index,
        status: QuestionDisplayerStatus.answerSelected,
      ),
    );
  }
}
