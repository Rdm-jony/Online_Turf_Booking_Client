part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}
abstract class RegisterActionState extends RegisterState{}

 class RegisterInitial extends RegisterState {}
 class SendOtpSuccessState extends RegisterActionState{}
 class LogInSuccessState extends RegisterActionState{}
