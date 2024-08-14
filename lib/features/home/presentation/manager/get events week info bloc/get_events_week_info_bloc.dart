import 'package:pmf_admin/features/home/data/model/events_week_info.dart';
import 'package:pmf_admin/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_events_week_info_event.dart';
part 'get_events_week_info_state.dart';

class GetEventsWeekInfoBloc
    extends Bloc<GetEventsWeekInfoEvent, GetEventsWeekInfoState> {
  final HomeRepo _homeRepo;
  GetEventsWeekInfoBloc(this._homeRepo) : super(GetEventsWeekInfoInitial()) {
    on<GetEventsWeekInfoEvent>((event, emit) async {
      if (event is GetEventsWeekInfo) {
        emit(GetEventsWeekInfoLoading());
        var result = await _homeRepo.getEventsWeekInfo(event.date);
        result.fold((left) {
          emit(GetEventsWeekInfoFailure(err: left.errMessage));
        }, (right) {
          emit(GetEventsWeekInfoSuccess(eventsWeekInfo: right));
        });
      }
    });
  }
}
