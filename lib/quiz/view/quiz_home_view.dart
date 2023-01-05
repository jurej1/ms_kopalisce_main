import 'package:flutter/material.dart';

import '../../home/home.dart';
import 'view.dart';

class QuizHomeView extends StatelessWidget {
  const QuizHomeView({Key? key}) : super(key: key);

  static route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) {
        return const QuizHomeView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Start the Quiz
            Navigator.of(context).push(QuizView.route(context));
          },
          child: const Text('Start Quiz'),
        ),
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}
