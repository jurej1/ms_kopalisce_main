part of 'additional_info_bloc.dart';

abstract class AdditionalInfoState extends Equatable {
  const AdditionalInfoState();

  @override
  List<Object> get props => [];
}

class AdditionalInfoLoading extends AdditionalInfoState {}

class AdditionalInfoLoadSuccess extends AdditionalInfoState {
  final List<AdditionalInfo> values;

  const AdditionalInfoLoadSuccess(this.values);
}

class AdditionalInfoFail extends AdditionalInfoState {}
