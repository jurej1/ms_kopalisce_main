import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/models.dart';

class PriceRepository {
  PriceRepository({FirebaseFirestore? firebaseFirestore}) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  FirebaseFirestore _firebaseFirestore;

  CollectionReference get _bathroomServicesRef => _firebaseFirestore.collection('bathroom_services');

  Future<QuerySnapshot> loadBathroomServicesPriceList() async {
    return _bathroomServicesRef.get();
  }

  Future<DocumentReference> addTicket(Ticket ticket) async {
    return _bathroomServicesRef.add(ticket.toDocumentSnapshot());
  }

  Future<void> deleteTicketById(String id) async {
    return _bathroomServicesRef.doc(id).delete();
  }

  Future<void> updateTicket(Ticket ticket) async {
    return _bathroomServicesRef.doc(ticket.id).update(ticket.toDocumentSnapshot());
  }
}
