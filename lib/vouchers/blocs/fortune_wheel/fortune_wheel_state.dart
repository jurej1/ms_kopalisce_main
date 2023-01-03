part of 'fortune_wheel_cubit.dart';

enum FortuneWheelStatus {
  initial,
  spinning,
  done,
}

class FortuneWheelState extends Equatable {
  const FortuneWheelState({this.status = FortuneWheelStatus.initial, required this.items});

  final FortuneWheelStatus status;
  final List<Voucher> items;

  @override
  List<Object> get props => [status, items];

  FortuneWheelState copyWith({
    FortuneWheelStatus? status,
    List<Voucher>? items,
  }) {
    return FortuneWheelState(
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }

  int roll() {
    final Random random = Random();
    return random.nextInt(items.length - 1);
  }
}
