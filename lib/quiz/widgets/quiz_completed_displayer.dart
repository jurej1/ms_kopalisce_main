import 'package:flutter/material.dart';

class QuizCompletedDisplayer extends StatelessWidget {
  const QuizCompletedDisplayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text('Quiz Completed'),
        ),
      ],
    );
  }
}
