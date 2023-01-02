import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:price_repository/price_repository.dart';

part 'bathroom_services_event.dart';
part 'bathroom_services_state.dart';

class BathroomServicesBloc extends Bloc<BathroomServicesEvent, BathroomServicesState> {
  BathroomServicesBloc({
    required PriceRepository priceRepository,
  })  : _priceRepository = priceRepository,
        super(BathroomServicesLoading());

  final PriceRepository _priceRepository;

  @override
  Stream<BathroomServicesState> mapEventToState(BathroomServicesEvent event) async* {
    if (event is BathroomServicesLoadRequested) {
      yield* _mapLoadRequestedToState();
    }
  }

  Stream<BathroomServicesState> _mapLoadRequestedToState() async* {
    try {
      yield BathroomServicesLoading();

      QuerySnapshot querySnapshot = await _priceRepository.loadBathroomServicesPriceList();
      List<Ticket> tickets = querySnapshot.docs.map((e) => Ticket.fromDocuntSnapshot(e)).toList();

      yield BathroomServicesLoadSuccess(tickets);
    } catch (e) {
      yield BathroomServicesLoadFail();
    }
  }
}
