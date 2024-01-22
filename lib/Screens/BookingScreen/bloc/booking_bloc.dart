import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/BookingScreen/Repo/BookingRepo.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<StartTimeListEvent>(startTimeListEvent);
    on<EndTimeListEvent>(endTimeListEvent);
    on<TotalpriceEvent>(totalpriceEvent);
    on<SubmitBookingInfoEvent>(submitBookingInfoEvent);
    on<AvailableTimeSlotEvent>(availableTimeSlotEvent);
  }

  FutureOr<void> startTimeListEvent(
      StartTimeListEvent event, Emitter<BookingState> emit) async {
    List startTimeList = await BookingRepo.startTimeList(event.clockTime);
    // print(startTimeList);

    emit(StartTimeListState(startTimeList: startTimeList));
  }

  FutureOr<void> endTimeListEvent(
      EndTimeListEvent event, Emitter<BookingState> emit) async {
    List endTimeList =
        await BookingRepo.endTimeList(event.clockTime, event.fromTime);
    emit(EndTimeListState(endTimeList: endTimeList));
  }

  FutureOr<void> totalpriceEvent(
      TotalpriceEvent event, Emitter<BookingState> emit) async {
    String totalPrice =
        await BookingRepo.totalPriceForSlot(event.timeSlot, event.price);
    emit(TotalPriceState(totalPrice: totalPrice));
  }

  FutureOr<void> submitBookingInfoEvent(
      SubmitBookingInfoEvent event, Emitter<BookingState> emit) async {
    String url = await BookingRepo.bookingInfoToDb(event.bookingInfo);
    if (url.isNotEmpty) {
      emit(SubmitBookingInfoState(url: url));
    }
  }

  FutureOr<void> availableTimeSlotEvent(
      AvailableTimeSlotEvent event, Emitter<BookingState> emit) async {

    emit(AvailableTimeLoadingState());
    List availableTime = await BookingRepo.fetchAvailableTimeSlot(
        event.date, event.turfId, event.eventName, event.weekday);
    emit(AvailableTimeSuccessState(availableTime: availableTime));
  }
}
