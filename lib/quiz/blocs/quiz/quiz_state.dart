part of 'quiz_bloc.dart';

abstract class QuizState {
  const QuizState();
}

class QuizLoading extends QuizState {}

class QuizLoadSuccess extends QuizState {
  final List<Question> questions;

  const QuizLoadSuccess(this.questions);
}

class QuizFail extends QuizState {}
