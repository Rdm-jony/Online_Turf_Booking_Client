import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/MybookingScreen/Repo/MybookingRepo.dart';

part 'mybooking_event.dart';
part 'mybooking_state.dart';

class MybookingBloc extends Bloc<MybookingEvent, MybookingState> {
  MybookingBloc() : super(MybookingInitial()) {
    on<FatchMyBookingEvent>(fatchMyBookingEvent);
  }

  FutureOr<void> fatchMyBookingEvent(
      FatchMyBookingEvent event, Emitter<MybookingState> emit) async {
    emit(FatchMyBookingsLoadingState());
    List allBookings = await MyBookingRepo.fatchAllBooking();
    emit(FatchMyBookingsSuccessState(allBookings: allBookings));
  }
}
