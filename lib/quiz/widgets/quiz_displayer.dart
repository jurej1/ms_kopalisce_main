import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/quiz/quiz.dart';
import 'package:quiz_repository/quiz_repository.dart';

class QuizDisplayer extends StatelessWidget {
  const QuizDisplayer._({Key? key}) : super(key: key);

  static provider(List<Question> questions) {
    return BlocProvider(
      create: (context) => QuizDisplayerCubit(questions: questions),
      child: const QuizDisplayer._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<QuizDisplayerCubit, QuizDisplayerState>(
      builder: (context, state) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                height: 20,
                width: size.width,
                color: Colors.blue,
              ),
              Expanded(
                child: QuestionDisplayer.provider(state.question[0]),
              ),
            ],
          ),
        );
      },
    );
  }
}
