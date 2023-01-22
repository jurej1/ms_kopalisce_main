import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coupon_repository/coupon_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:ms_kopalisce_main/quiz/blocs/blocs.dart';

part 'quiz_reward_event.dart';
part 'quiz_reward_state.dart';

class QuizRewardBloc extends Bloc<QuizRewardEvent, QuizRewardState> {
  QuizRewardBloc({
    required this.couponRepository,
    required this.quizAnswerRecordCubit,
  }) : super(QuizRewardInitial());

  final CouponRepository couponRepository;
  final QuizAnswerRecordCubit quizAnswerRecordCubit;

  @override
  Stream<QuizRewardState> mapEventToState(QuizRewardEvent event) async* {
    if (event is QuizRewardLoadRequested) {
      yield* _mapLoadRequestedToState(event);
    }
  }

  Stream<QuizRewardState> _mapLoadRequestedToState(QuizRewardLoadRequested event) async* {
    if (quizAnswerRecordCubit.areAllAnwsersCorrect) {
      yield QuizRewardLoading();

      try {
        QuerySnapshot querySnapshot = await couponRepository.loadAllVouchers();

        List<Voucher> vouchers = querySnapshot.docs.map((e) => Voucher.fromDocumentSnapshot(e)).toList();
        vouchers.shuffle();

        Voucher reward = vouchers.first;

        yield QuizRewardSuccess(reward);
      } catch (error) {
        yield QuizRewardFail();
      }
    }
  }
}
