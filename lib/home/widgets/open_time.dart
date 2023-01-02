import 'package:flutter/material.dart';

@immutable
class OpenTime extends StatelessWidget {
  const OpenTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Odpiralni Cas',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _OpenDayDisplayer(dayOfTheWeek: 'Ponedeljek', time: '8:00-20:00'),
              _OpenDayDisplayer(dayOfTheWeek: 'Torek', time: '8:00-20:00'),
              _OpenDayDisplayer(dayOfTheWeek: 'Sreda', time: '8:00-20:00'),
              _OpenDayDisplayer(dayOfTheWeek: 'Cetrtek', time: '8:00-20:00'),
              _OpenDayDisplayer(dayOfTheWeek: 'Petek', time: '8:00-20:00'),
              _OpenDayDisplayer(dayOfTheWeek: 'Sobota', time: '8:00-20:00'),
              _OpenDayDisplayer(dayOfTheWeek: 'Nedelja', time: '8:00-20:00'),
            ],
          ),
        ),
      ],
    );
  }
}

class _OpenDayDisplayer extends StatelessWidget {
  const _OpenDayDisplayer({
    Key? key,
    required this.dayOfTheWeek,
    required this.time,
  }) : super(key: key);

  final String dayOfTheWeek;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dayOfTheWeek),
          Text(time),
        ],
      ),
    );
  }
}
