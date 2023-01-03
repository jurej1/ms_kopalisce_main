part of 'fortune_wheel_winner_picker_bloc.dart';

abstract class FortuneWheelWinnerPickerEvent extends Equatable {
  const FortuneWheelWinnerPickerEvent();

  @override
  List<Object> get props => [];
}

class FortuneWheelWinnerPicked extends FortuneWheelWinnerPickerEvent {
  final int index;

  const FortuneWheelWinnerPicked(this.index);

  @override
  List<Object> get props => [index];
}
