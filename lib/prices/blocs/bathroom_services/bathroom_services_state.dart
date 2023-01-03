part of 'bathroom_services_bloc.dart';

abstract class BathroomServicesState {
  const BathroomServicesState();
}

class BathroomServicesLoading extends BathroomServicesState {}

class BathroomServicesLoadSuccess extends BathroomServicesState {
  final List<Ticket> tickets;

  const BathroomServicesLoadSuccess(this.tickets);
}

class BathroomServicesLoadFail extends BathroomServicesState {}
