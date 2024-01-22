part of 'profile_info_bloc.dart';

@immutable
abstract class ProfileInfoEvent {}

class SendUserInfoToDbEvent extends ProfileInfoEvent {
  final Object userInfo;

  SendUserInfoToDbEvent({required this.userInfo});
}
