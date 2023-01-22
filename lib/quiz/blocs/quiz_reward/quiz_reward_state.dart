part of 'quiz_reward_bloc.dart';

abstract class QuizRewardState extends Equatable {
  const QuizRewardState();

  @override
  List<Object> get props => [];
}

class QuizRewardInitial extends QuizRewardState {}

class QuizRewardLoading extends QuizRewardState {}

class QuizRewardSuccess extends QuizRewardState {
  final Voucher value;

  const QuizRewardSuccess(this.value);

  @override
  List<Object> get props => [value];
}

class QuizRewardFail extends QuizRewardState {}
