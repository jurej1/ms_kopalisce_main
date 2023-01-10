import 'package:flutter/material.dart';
import 'package:quiz_repository/quiz_repository.dart';

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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              fit: BoxFit.fill,
              height: size.height * 0.4,
              QuizImages.sobotaSvica,
              package: 'quiz_repository',
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  //Start the Quiz
                  Navigator.of(context).push(QuizView.route(context));
                },
                child: const Text('Začni z Kvizem'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeViewSelector(),
    );
  }
}
