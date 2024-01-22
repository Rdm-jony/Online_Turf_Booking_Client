part of 'spots_bloc.dart';

@immutable
abstract class SpotsState {}

abstract class SpotsActionState extends SpotsState {}

class SpotsInitial extends SpotsState {}

class AllSpotsLoadingState extends SpotsState {}

class AllSpotsSuccessState extends SpotsState {
  final List allSpots;

  AllSpotsSuccessState({required this.allSpots});
}

class NavigateToTurfDetailsState extends SpotsActionState {
  final  turfDetails;

  NavigateToTurfDetailsState({required this.turfDetails});
}
