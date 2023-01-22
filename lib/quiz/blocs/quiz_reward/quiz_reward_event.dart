part of 'quiz_reward_bloc.dart';

abstract class QuizRewardEvent extends Equatable {
  const QuizRewardEvent();

  @override
  List<Object> get props => [];
}

class QuizRewardLoadRequested extends QuizRewardEvent {}
