import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_kopalisce_main/quiz/blocs/blocs.dart';
import 'package:quiz_repository/quiz_repository.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({Key? key, required this.answer}) : super(key: key);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionDisplayerCubit, QuestionDisplayerState>(
      builder: (context, state) {
        final isAnwserSelectedStatus = state.status.isAnswerSelected;

        return Card(
          color: getColorsBasedOnStatus(state),
          elevation: 3,
          child: InkWell(
            onTap: () {
              if (!isAnwserSelectedStatus) {
                BlocProvider.of<QuestionDisplayerCubit>(context).anwserSelected(answer.id);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  answer.text,
                  maxLines: 3,
                  style: const TextStyle(
                    overflow: TextOverflow.clip,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color getColorsBasedOnStatus(QuestionDisplayerState state) {
    final isAnwserSelectedStatus = state.status.isAnswerSelected;

    bool isThisRightAnwser = answer.id == state.question.rightAnwser.id;

    return isAnwserSelectedStatus ? (isThisRightAnwser ? Colors.green : Colors.red) : Colors.blue;
  }
}
