import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:info_repository/info_repository.dart';

part 'open_time_event.dart';
part 'open_time_state.dart';

class OpenTimeBloc extends Bloc<OpenTimeEvent, OpenTimeState> {
  OpenTimeBloc(
    this.infoRepository,
  ) : super(OpenTimeLoading());

  final InfoRepository infoRepository;

  @override
  Stream<OpenTimeState> mapEventToState(OpenTimeEvent event) async* {
    if (event is OpenTimeLoadRequested) {
      yield* _mapLoadToState();
    }
  }

  Stream<OpenTimeState> _mapLoadToState() async* {
    yield (OpenTimeLoading());

    try {
      DocumentSnapshot snapshot = await infoRepository.getOpenTime();

      OpenTime val = OpenTime.fromDocumentSnapshot(snapshot);

      yield OpenTimeSuccess(val);
    } catch (e) {
      yield (OpenTimeFail());
    }
  }
}
