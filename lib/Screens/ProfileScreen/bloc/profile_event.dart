part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class FatchProfileInfoEvent extends ProfileEvent {}

class UploadProfilePhotoEvent extends ProfileEvent {
  final imagePath;

  UploadProfilePhotoEvent({required this.imagePath});
}
