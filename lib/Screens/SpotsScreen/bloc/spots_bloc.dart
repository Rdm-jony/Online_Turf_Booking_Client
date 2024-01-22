import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/SpotsScreen/Model/SpotsTurfModel.dart';
import 'package:playspot_client/Screens/SpotsScreen/Repo/SpotScreenRepo.dart';

part 'spots_event.dart';
part 'spots_state.dart';

class SpotsBloc extends Bloc<SpotsEvent, SpotsState> {
  SpotsBloc() : super(SpotsInitial()) {
    on<FatchSpotsEvent>(fatchSpotsEvent);
    on<NavigateToTurfDetailsEvent>(navigateToTurfDetailsEvent);
    on<FilterByEventNameEvent>(filterByEventNameEvent);
    on<FilerBySearchTexttEvent>(filerBySearchTexttEvent);
  }

  FutureOr<void> fatchSpotsEvent(
      FatchSpotsEvent event, Emitter<SpotsState> emit) async {
    

    emit(AllSpotsLoadingState());
    List allSpots = await SpotScreenRepo.fatchAllTurf(event.division);

    emit(AllSpotsSuccessState(allSpots: allSpots));
  }

  FutureOr<void> navigateToTurfDetailsEvent(
      NavigateToTurfDetailsEvent event, Emitter<SpotsState> emit) {
    emit(NavigateToTurfDetailsState(turfDetails: event.turfDetails));
  }

  FutureOr<void> filterByEventNameEvent(
      FilterByEventNameEvent event, Emitter<SpotsState> emit) async {
    List allFilterSpot =
        await SpotScreenRepo.filteringAllSpots(event.eventName);
    emit(AllSpotsSuccessState(allSpots: allFilterSpot));
  }

  FutureOr<void> filerBySearchTexttEvent(
      FilerBySearchTexttEvent event, Emitter<SpotsState> emit) async {
    List allFilterSpot =
        await SpotScreenRepo.filteringAllSpotsByText(event.searchText);
    emit(AllSpotsSuccessState(allSpots: allFilterSpot));
  }
}
