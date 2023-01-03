part of 'fortune_wheel_winner_picker_bloc.dart';

abstract class FortuneWheelWinnerPickerState extends Equatable {
  const FortuneWheelWinnerPickerState();

  @override
  List<Object> get props => [];
}

class FortuneWheelWinnerPickerInitial extends FortuneWheelWinnerPickerState {}

class FortuneWheelWinnerPickerLoading extends FortuneWheelWinnerPickerState {}

class FortuneWheelWinnerPickerLoadSuccess extends FortuneWheelWinnerPickerState {
  final VoucherUser item;

  const FortuneWheelWinnerPickerLoadSuccess(this.item);

  @override
  List<Object> get props => [item];
}

class FortuneWheelWinnerPickerFailure extends FortuneWheelWinnerPickerState {}
