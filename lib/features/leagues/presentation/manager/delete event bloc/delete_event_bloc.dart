import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_event_event.dart';
part 'delete_event_state.dart';

class DeleteEventBloc extends Bloc<DeleteEventEvent, DeleteEventState> {
  final EventsRepo _eventsRepo;
  DeleteEventBloc(this._eventsRepo) : super(DeleteEventInitial()) {
    on<DeleteEventEvent>((event, emit) async {
      if (event is DeleteEvent) {
        emit(DeleteEventLoading());
        var result = await _eventsRepo.deleteEvent(event.event);
        result.fold((left) {
          emit(DeleteEventFailure(err: left.errMessage));
        }, (right) {
          emit(DeleteEventSuccess(msg: 'Événement supprimer avec succès'));
        });
      }
    });
  }
}
