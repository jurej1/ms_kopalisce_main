import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:info_repository/info_repository.dart';

part 'additional_info_event.dart';
part 'additional_info_state.dart';

class AdditionalInfoBloc extends Bloc<AdditionalInfoEvent, AdditionalInfoState> {
  AdditionalInfoBloc(
    this.infoRepository,
  ) : super(AdditionalInfoLoading());

  final InfoRepository infoRepository;

  @override
  Stream<AdditionalInfoState> mapEventToState(AdditionalInfoEvent event) async* {
    if (event is AdditionalInfoLoadRequested) {
      yield* _mapLoadRequestedToState();
    }
  }

  Stream<AdditionalInfoState> _mapLoadRequestedToState() async* {
    yield AdditionalInfoLoading();

    try {
      QuerySnapshot querySnapshot = await infoRepository.getAdditionalInfo();

      if (querySnapshot.docs.isEmpty) {
        yield const AdditionalInfoLoadSuccess([]);
      } else {
        final values = querySnapshot.docs.map((e) => AdditionalInfo.fromDocumentSnapshot(e)).toList();

        yield AdditionalInfoLoadSuccess(values);
      }
    } catch (e) {
      yield AdditionalInfoFail();
    }
  }
}
