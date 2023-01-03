part of 'fortune_wheel_cubit.dart';

enum FortuneWheelStatus {
  initial,
  spinning,
  done,
}

class FortuneWheelState extends Equatable {
  const FortuneWheelState({
    required this.status,
    required this.items,
    required this.selectedIndex,
  });

  final FortuneWheelStatus status;
  final List<Voucher> items;
  final int selectedIndex;

  @override
  List<Object> get props => [status, items, selectedIndex];

  FortuneWheelState copyWith({
    FortuneWheelStatus? status,
    List<Voucher>? items,
    int? selectedIndex,
  }) {
    return FortuneWheelState(
      status: status ?? this.status,
      items: items ?? this.items,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  int roll() {
    final Random random = Random();
    return random.nextInt(items.length - 1);
  }
}
