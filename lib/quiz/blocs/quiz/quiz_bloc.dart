import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_repository/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required QuizRepository quizRepository,
  })  : _quizRepository = quizRepository,
        super(QuizLoading());

  final QuizRepository _quizRepository;

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is QuizLoadRequested) {
      yield* _mapLoadRequestedToState();
    }
  }

  Stream<QuizState> _mapLoadRequestedToState() async* {
    yield QuizLoading();

    try {
      QuerySnapshot snapshot = await _quizRepository.loadAllQuestions();

      List<Question> questions = snapshot.docs.map((e) => Question.fromDocumentSnapshot(e)).toList()
        ..shuffle()
        ..take(4);

      log('questions length: ${questions.length}');

      yield QuizLoadSuccess(questions);
    } catch (error) {
      yield QuizFail();
    }
  }
}
