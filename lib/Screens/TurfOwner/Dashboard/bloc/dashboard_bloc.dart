import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/TurfOwner/Dashboard/Repo/DashboardRepo.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<TurfInfoAddToDbEvent>(turfInfoAddToDbEvent);
  }

  FutureOr<void> turfInfoAddToDbEvent(
      TurfInfoAddToDbEvent event, Emitter<DashboardState> emit) async {
    bool isTrue = await DashboardRepo.turfInfoSendToDb(event.turfInfo);
    if (isTrue) {
      emit(TurfInfoAddToDbSuccessState());
    }
   
  }
}
