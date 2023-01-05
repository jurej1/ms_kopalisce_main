import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../quiz.dart';

class QuizCompletedDisplayer extends StatelessWidget {
  const QuizCompletedDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text('Quiz Completed'),
        ),
        BlocBuilder<QuizAnswerRecordCubit, List<bool>>(
          builder: (context, state) {
            final nrRight = state.where((element) => element).toList().length;
            return Text('Pravilno: $nrRight / ${state.length}');
          },
        )
      ],
    );
  }
}
