import 'package:pmf_admin/features/leagues/data/repo/league_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'add_event_event.dart';
part 'add_event_state.dart';

class AddEventBloc extends Bloc<AddEventEvent, AddEventState> {
  final EventsRepo _eventsRepo;
  AddEventBloc(this._eventsRepo) : super(AddEventInitial()) {
    on<AddEventEvent>((event, emit) async {
      if (event is AddEvent) {
        emit(AddEventLaoding());
        var result = await _eventsRepo.addEvent(
          event.title,
          event.description,
          event.place,
          event.date,
          event.image,
        );
        result.fold((left) {
          emit(AddEventFailure(err: left.errMessage));
        }, (right) {
          emit(AddEventSuccess(msg: 'Événement ajouté avec succès'));
        });
      }
    });
  }
}
