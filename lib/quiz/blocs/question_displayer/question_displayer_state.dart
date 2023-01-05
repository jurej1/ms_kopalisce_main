part of 'question_displayer_cubit.dart';

enum QuestionDisplayerStatus { pure, answerSelected }

extension QuestionDisplayerStatusX on QuestionDisplayerStatus {
  bool get isAnswerSelected => this == QuestionDisplayerStatus.answerSelected;
}

class QuestionDisplayerState extends Equatable {
  const QuestionDisplayerState({
    required this.question,
    required this.status,
    required this.selectedAnwserIndex,
  });

  final Question question;
  final QuestionDisplayerStatus status;
  final int? selectedAnwserIndex;

  @override
  List<Object?> get props => [question, status, selectedAnwserIndex];

  QuestionDisplayerState copyWith({
    Question? question,
    QuestionDisplayerStatus? status,
    int? selectedAnwserIndex,
  }) {
    return QuestionDisplayerState(
      question: question ?? this.question,
      status: status ?? this.status,
      selectedAnwserIndex: selectedAnwserIndex ?? this.selectedAnwserIndex,
    );
  }

  bool get isSelectedAnwserCorrect => question.rightAnwser.id == selectedAnwserIndex;
}
