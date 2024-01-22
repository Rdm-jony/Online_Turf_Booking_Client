part of 'mybooking_bloc.dart';

@immutable
abstract class MybookingState {}

abstract class MybookingActionState extends MybookingState {}

class MybookingInitial extends MybookingState {}

class FatchMyBookingsLoadingState extends MybookingState {}

class FatchMyBookingsSuccessState extends MybookingState {
  final List allBookings;

  FatchMyBookingsSuccessState({required this.allBookings});
}
