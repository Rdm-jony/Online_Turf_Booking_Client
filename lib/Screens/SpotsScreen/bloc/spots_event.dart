part of 'spots_bloc.dart';

@immutable
abstract class SpotsEvent {}

class FatchSpotsEvent extends SpotsEvent {
  final division;

  FatchSpotsEvent({this.division});
}

class NavigateToTurfDetailsEvent extends SpotsEvent {
  final turfDetails;

  NavigateToTurfDetailsEvent({required this.turfDetails});
}

class FilterByEventNameEvent extends SpotsEvent {
  final eventName;

  FilterByEventNameEvent({required this.eventName});
}

class FilerBySearchTexttEvent extends SpotsEvent {
  final searchText;

  FilerBySearchTexttEvent({required this.searchText});
}
