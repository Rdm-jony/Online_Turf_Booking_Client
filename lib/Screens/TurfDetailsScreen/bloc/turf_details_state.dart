part of 'turf_details_bloc.dart';

@immutable
abstract class TurfDetailsState {}

 class TurfDetailsInitial extends TurfDetailsState {}
 class TurfDetailsActionState extends TurfDetailsState{}
 class NavigateToPricingScreenState extends TurfDetailsActionState{}
