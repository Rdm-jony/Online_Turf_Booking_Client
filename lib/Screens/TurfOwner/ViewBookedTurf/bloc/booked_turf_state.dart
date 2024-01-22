part of 'booked_turf_bloc.dart';

@immutable
abstract class BookedTurfState {}

abstract class BookedTurfActionState extends BookedTurfState {}

class BookedTurfInitial extends BookedTurfState {}

class FatchBookedTurfLoadingState extends BookedTurfState {}

class FatchBookedTurfSuccessState extends BookedTurfState {
  final allBooked;

  FatchBookedTurfSuccessState({required this.allBooked});
}
