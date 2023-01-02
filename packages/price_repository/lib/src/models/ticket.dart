import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum TicketType { daily, afternoon, seasonal, sets }

extension TicketTypeX on TicketType {
  String toJson() {
    return describeEnum(this);
  }

  static TicketType fromJson(String val) {
    return TicketType.values.firstWhere((element) {
      return describeEnum(element) == val;
    });
  }
}

class Ticket extends Equatable {
  final String title;
  final double price;
  final String id;
  final TicketType type;

  const Ticket({
    required this.title,
    required this.price,
    required this.id,
    required this.type,
  });

  @override
  List<Object> get props => [title, price, id, type];

  Ticket copyWith({
    String? title,
    double? price,
    String? id,
    TicketType? type,
  }) {
    return Ticket(
      title: title ?? this.title,
      price: price ?? this.price,
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toDocumentSnapshot() {
    return {
      'title': title,
      'price': price,
      'type': type.toJson(),
    };
  }

  factory Ticket.fromDocuntSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;

    return Ticket(
      title: data['title'],
      price: data['price'],
      id: snap.id,
      type: TicketTypeX.fromJson(data['type']),
    );
  }
}
