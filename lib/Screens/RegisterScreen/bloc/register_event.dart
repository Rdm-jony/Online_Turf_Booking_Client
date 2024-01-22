part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class SendOtpEvent extends RegisterEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});
}

class SigninWithGoogleEvent extends RegisterEvent{}