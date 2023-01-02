part of 'bathroom_services_bloc.dart';

abstract class BathroomServicesState {
  const BathroomServicesState();
}

class BathroomServicesLoading extends BathroomServicesState {}

class BathroomServicesLoadSucces extends BathroomServicesState {
  final List<Ticket> tickets;

  const BathroomServicesLoadSucces(this.tickets);
}

class BathroomServicesLoadFail extends BathroomServicesState {}
