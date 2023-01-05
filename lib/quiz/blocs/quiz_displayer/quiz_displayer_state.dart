part of 'quiz_displayer_cubit.dart';

enum QuizDisplayerStatus { pure, playing, done }

class QuizDisplayerState extends Equatable {
  const QuizDisplayerState({
    required this.question,
    required this.activeQuestionIndex,
    required this.status,
  });

  final List<Question> question;
  final int activeQuestionIndex;
  final QuizDisplayerStatus status;

  @override
  List<Object> get props => [question, activeQuestionIndex];

  QuizDisplayerState copyWith({
    List<Question>? question,
    int? activeQuestionIndex,
    QuizDisplayerStatus? status,
  }) {
    return QuizDisplayerState(
      question: question ?? this.question,
      activeQuestionIndex: activeQuestionIndex ?? this.activeQuestionIndex,
      status: status ?? this.status,
    );
  }
}
