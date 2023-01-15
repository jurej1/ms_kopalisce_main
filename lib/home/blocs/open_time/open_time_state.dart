part of 'open_time_bloc.dart';

abstract class OpenTimeState extends Equatable {
  const OpenTimeState();

  @override
  List<Object> get props => [];
}

class OpenTimeLoading extends OpenTimeState {}

class OpenTimeSuccess extends OpenTimeState {
  final OpenTime openTime;

  const OpenTimeSuccess(this.openTime);
}

class OpenTimeFail extends OpenTimeState {}
