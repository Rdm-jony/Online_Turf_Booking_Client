import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/TurfOwner/ViewBookedTurf/Repo/BookedTurfRepo.dart';

part 'booked_turf_event.dart';
part 'booked_turf_state.dart';

class BookedTurfBloc extends Bloc<BookedTurfEvent, BookedTurfState> {
  BookedTurfBloc() : super(BookedTurfInitial()) {
    on<FatchBookedTurfEvent>(fatchBookedTurfEvent);
  }

  FutureOr<void> fatchBookedTurfEvent(
      FatchBookedTurfEvent event, Emitter<BookedTurfState> emit) async {
    emit(FatchBookedTurfLoadingState());
    List allBooked = await BookedTurfRepo.fatchAllBooking();
    emit(FatchBookedTurfSuccessState(allBooked: allBooked));
  }
}
