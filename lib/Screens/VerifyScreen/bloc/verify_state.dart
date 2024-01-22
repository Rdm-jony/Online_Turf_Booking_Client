part of 'verify_bloc.dart';

@immutable
abstract class VerifyState {}
abstract class VerifyActionState extends VerifyState{}

 class VerifyInitial extends VerifyState {}
 class VerifySuccessState extends VerifyActionState{}

