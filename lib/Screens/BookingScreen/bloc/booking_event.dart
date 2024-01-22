part of 'booking_bloc.dart';

@immutable
abstract class BookingEvent {}

class StartTimeListEvent extends BookingEvent {
  final List clockTime;

  StartTimeListEvent({required this.clockTime});
}

class EndTimeListEvent extends BookingEvent {
  final List clockTime;
  final String fromTime;

  EndTimeListEvent({required this.clockTime, required this.fromTime});
}

class TotalpriceEvent extends BookingEvent {
  final List timeSlot;
  final String price;

  TotalpriceEvent({required this.timeSlot, required this.price});
}

class SubmitBookingInfoEvent extends BookingEvent {
  final bookingInfo;

  SubmitBookingInfoEvent({required this.bookingInfo});
}

class AvailableTimeSlotEvent extends BookingEvent {
  final date;
  final eventName;
  final turfId;
  final weekday;

  AvailableTimeSlotEvent({required this.weekday,required this.date,required this.eventName,required this.turfId});
}
