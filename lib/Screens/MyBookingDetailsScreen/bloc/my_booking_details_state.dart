part of 'my_booking_details_bloc.dart';

@immutable
abstract class MyBookingDetailsState {}
abstract class MyBookingDetailsActionState extends MyBookingDetailsState{}

 class MyBookingDetailsInitial extends MyBookingDetailsState {}   
 class SendFeedbackToDbSuccessState extends MyBookingDetailsActionState {}   
 
