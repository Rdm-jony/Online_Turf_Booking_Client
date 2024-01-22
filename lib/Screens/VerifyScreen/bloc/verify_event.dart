part of 'verify_bloc.dart';

@immutable
abstract class VerifyEvent {}

class VerifyNumberEvent extends VerifyEvent {
  final smsCode;

  VerifyNumberEvent({required this.smsCode});
}

class ResendCodeEvent extends VerifyEvent {
  final String phoneNumber;

  ResendCodeEvent({required this.phoneNumber});

}
