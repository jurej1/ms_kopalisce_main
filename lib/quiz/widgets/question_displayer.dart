import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:quiz_repository/quiz_repository.dart';

import 'package:ms_kopalisce_main/quiz/quiz.dart';

class QuestionDisplayer extends StatelessWidget {
  const QuestionDisplayer._({Key? key}) : super(key: key);

  static provider(Question question) {
    return BlocProvider(
      key: ValueKey(question),
      create: (context) => QuestionDisplayerCubit(question: question),
      child: const QuestionDisplayer._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<QuestionDisplayerCubit, QuestionDisplayerState>(
      listener: (context, state) {
        if (state.status.isAnswerSelected) {
          BlocProvider.of<QuizAnswerRecordCubit>(context).anwserAdded(state.isSelectedAnwserCorrect);

          // ignore: avoid_single_cascade_in_expression_statements
          Flushbar(
            icon: state.isSelectedAnwserCorrect
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
            message: state.isSelectedAnwserCorrect ? 'Pravilno' : 'Narobe',
            flushbarStyle: FlushbarStyle.FLOATING,
            titleColor: state.isSelectedAnwserCorrect ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(10),
            isDismissible: false,
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            duration: const Duration(milliseconds: 1500),
            animationDuration: const Duration(milliseconds: 300),
          ).show(context).then((value) {
            BlocProvider.of<QuizDisplayerCubit>(context).activeQuestionForward();
          });
        }
      },
      builder: (context, state) {
        return ScrollConfiguration(
          behavior: QuizScrollBehaviour(),
          child: ListView(
            shrinkWrap: true,
            children: [
              _TextDisplayer(text: state.question.questionText),
              GridView.builder(
                padding: const EdgeInsets.all(10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: size.height * 0.2,
                ),
                itemCount: state.question.anwsers.length,
                itemBuilder: (context, index) {
                  final item = state.question.anwsers[index];
                  return AnswerCard(answer: item);
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class QuizScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _TextDisplayer extends StatelessWidget {
  final String text;
  const _TextDisplayer({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.3,
      width: size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      alignment: Alignment.center,
      color: Colors.grey.withOpacity(0.1),
      child: Text(
        maxLines: 8,
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          overflow: TextOverflow.clip,
          fontSize: 16,
        ),
      ),
    );
  }
}
