part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class LocationLoadingState extends HomeState {}

class LocationState extends HomeState {
  final placeName;

  LocationState({required this.placeName});
}

class FacthDivisionSuccessState extends HomeState {
  final division;

  FacthDivisionSuccessState({required this.division});
}
