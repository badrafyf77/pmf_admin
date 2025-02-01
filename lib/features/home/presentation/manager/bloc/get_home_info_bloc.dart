import 'package:pmf_admin/features/home/data/model/home_info.dart';
import 'package:pmf_admin/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_home_info_event.dart';
part 'get_home_info_state.dart';

class GetHomeInfoBloc extends Bloc<GetHomeInfoEvent, GetHomeInfoState> {
  final HomeRepo _homeRepo;
  GetHomeInfoBloc(this._homeRepo) : super(GetHomeInfoInitial()) {
    on<GetHomeInfoEvent>((event, emit) async {
      if (event is GetHomeInfo) {
        emit(GetHomeInfoLoading());
        var result = await _homeRepo.getInfo(event.date);
        result.fold((left) {
          emit(GetHomeInfoFailure(err: left.errMessage));
        }, (right) {
          emit(GetHomeInfoSuccess(homeInfo: right));
        });
      }
    });
  }
}
