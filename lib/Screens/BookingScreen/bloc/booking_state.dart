part of 'booking_bloc.dart';

@immutable
abstract class BookingState {}

abstract class BookingActionState extends BookingState {}

class BookingInitial extends BookingState {}

class StartTimeListState extends BookingActionState {
  final List startTimeList;

  StartTimeListState({required this.startTimeList});
}

class EndTimeListState extends BookingActionState {
  final List endTimeList;

  EndTimeListState({required this.endTimeList});
}

class FromTimeSelectState extends BookingActionState {
  final fromTime;

  FromTimeSelectState({required this.fromTime});
}

class TotalPriceState extends BookingActionState {
  final String totalPrice;

  TotalPriceState({required this.totalPrice});
}

class SubmitBookingInfoState extends BookingActionState {
  final url;

  SubmitBookingInfoState({required this.url});
}

class AvailableTimeLoadingState extends BookingState {}

class AvailableTimeSuccessState extends BookingState {
  final List availableTime;

  AvailableTimeSuccessState({required this.availableTime});
}
