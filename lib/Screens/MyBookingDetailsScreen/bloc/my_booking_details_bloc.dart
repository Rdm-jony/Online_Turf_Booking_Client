import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/MyBookingDetailsScreen/Repo/MyBookingDetailsRepo.dart';

part 'my_booking_details_event.dart';
part 'my_booking_details_state.dart';

class MyBookingDetailsBloc
    extends Bloc<MyBookingDetailsEvent, MyBookingDetailsState> {
  MyBookingDetailsBloc() : super(MyBookingDetailsInitial()) {
    on<SendFeedbackToDbEvent>(sendFeedbackToDbEvent);
  }

  FutureOr<void> sendFeedbackToDbEvent(
      SendFeedbackToDbEvent event, Emitter<MyBookingDetailsState> emit) async {
    bool isSubmit =
        await MyBookingDetailsRepo.sendFeedbackToDb(event.reviewInfo);
    print(isSubmit);
    if (isSubmit) {
      emit(SendFeedbackToDbSuccessState());
    }
  }
}
