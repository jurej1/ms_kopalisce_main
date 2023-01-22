import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/quiz/quiz.dart';
import 'package:quiz_repository/quiz_repository.dart';

class QuizDisplayer extends StatelessWidget {
  QuizDisplayer._({Key? key}) : super(key: key);

  static provider(List<Question> questions) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuizDisplayerCubit(questions: questions),
        ),
        BlocProvider(
          create: (context) => QuizAnswerRecordCubit(),
        )
      ],
      child: QuizDisplayer._(),
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
              _ProgressBar(
                widthFactor: (state.activeQuestionIndex) / state.question.length,
              ),
              Expanded(
                child: state.status.isPlaying
                    ? QuestionDisplayer.provider(
                        state.question[state.activeQuestionIndex],
                      )
                    : const QuizCompletedDisplayer(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({Key? key, required this.widthFactor}) : super(key: key);

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _borderRadius = BorderRadius.circular(15);

    return Container(
      margin: const EdgeInsets.all(10),
      height: 10,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: _borderRadius,
      ),
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          widthFactor: widthFactor,
          child: Container(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
