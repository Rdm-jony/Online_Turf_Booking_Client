part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}
abstract class DashboardActionState extends DashboardState{}
 class DashboardInitial extends DashboardState {}
 class TurfInfoAddToDbSuccessState extends DashboardActionState{}
