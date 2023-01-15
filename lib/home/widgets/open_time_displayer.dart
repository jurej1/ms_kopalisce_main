import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_repository/info_repository.dart';

import 'package:intl/intl.dart';

import 'package:ms_kopalisce_main/home/blocs/blocs.dart';

class OpenTimeDisplayer extends StatelessWidget {
  const OpenTimeDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenTimeBloc, OpenTimeState>(
      builder: (context, state) {
        if (state is OpenTimeLoading) {
          return const LinearProgressIndicator();
        } else if (state is OpenTimeSuccess) {
          return _Builder(openTime: state.openTime);
        } else if (state is OpenTimeFail) {
          return Container();
        }
        return Container();
      },
    );
  }
}

class _Builder extends StatelessWidget {
  const _Builder({
    Key? key,
    required this.openTime,
  }) : super(key: key);

  final OpenTime openTime;

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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: DayOfWeek.values.map(
              (dayOfWeek) {
                OpenDay? val = openTime.getSpecificDayTime(dayOfWeek);
                return _OpenDayDisplayer(
                  val: val,
                  dayOfWeek: dayOfWeek,
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}

class _OpenDayDisplayer extends StatelessWidget {
  const _OpenDayDisplayer({Key? key, required this.val, required this.dayOfWeek}) : super(key: key);

  final OpenDay? val;
  final DayOfWeek dayOfWeek;

  @override
  Widget build(BuildContext context) {
    final openDateTime = DateTime(0, 0, 0, val!.opens!.hour, val!.opens!.minute);
    final closeDateTime = DateTime(0, 0, 0, val!.closes!.hour, val!.closes!.minute);
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dayOfWeek.toStringReadable()),
          const Spacer(),
          if (val?.opens != null) Text(DateFormat('HH:mm').format(openDateTime)),
          if (val != null) const Text(' - '),
          if (val?.closes != null) Text(DateFormat('HH:mm').format(closeDateTime)),
        ],
      ),
    );
  }
}
