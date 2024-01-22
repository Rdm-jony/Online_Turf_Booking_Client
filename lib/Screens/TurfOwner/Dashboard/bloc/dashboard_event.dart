part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class TurfInfoAddToDbEvent extends DashboardEvent {
  final Map turfInfo;

  TurfInfoAddToDbEvent({required this.turfInfo});
}
