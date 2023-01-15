part of 'additional_info_bloc.dart';

abstract class AdditionalInfoEvent extends Equatable {
  const AdditionalInfoEvent();

  @override
  List<Object> get props => [];
}

class AdditionalInfoLoadRequested extends AdditionalInfoEvent {}
