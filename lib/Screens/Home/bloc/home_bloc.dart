import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/Home/Repo/HomeRepo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FatchCategoryDivisionEvent>(fatchCategoryDivisionEvent);
  }

  FutureOr<void> fatchCategoryDivisionEvent(
      FatchCategoryDivisionEvent event, Emitter<HomeState> emit) async {
    List division = await HomeRepo.fatchCategoryOfDivision();
    emit(FacthDivisionSuccessState(division: division));
   
  }
}
