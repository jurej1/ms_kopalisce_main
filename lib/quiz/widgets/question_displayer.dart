import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/quiz/blocs/blocs.dart';
import 'package:ms_kopalisce_main/quiz/quiz.dart';
import 'package:quiz_repository/quiz_repository.dart';

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

    return BlocBuilder<QuestionDisplayerCubit, QuestionDisplayerState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: size.height * 0.3,
              width: size.width,
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
              child: Text(
                maxLines: 6,
                state.question.questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
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
        );
      },
    );
  }
}
