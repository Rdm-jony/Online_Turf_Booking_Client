part of 'my_booking_details_bloc.dart';

@immutable
abstract class MyBookingDetailsEvent {}

class SendFeedbackToDbEvent extends MyBookingDetailsEvent {
  final reviewInfo;

  SendFeedbackToDbEvent({required this.reviewInfo});
}
