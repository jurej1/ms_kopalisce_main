part of 'bathroom_services_bloc.dart';

abstract class BathroomServicesState {
  const BathroomServicesState();
}

class BathroomServicesLoading extends BathroomServicesState {}

class BathroomServicesLoadSuccess extends BathroomServicesState {
  final List<Ticket> tickets;

  const BathroomServicesLoadSuccess(this.tickets);

  List<Ticket> sortByType(TicketType type) {
    final elementsCopy = List<Ticket>.from(tickets);

    return elementsCopy.where((element) => element.type == type).toList()
      ..sort(
        (a, b) => a.price.compareTo(b.price),
      );
  }
}

class BathroomServicesLoadFail extends BathroomServicesState {}
