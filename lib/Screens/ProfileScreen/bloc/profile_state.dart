part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

abstract class ProfileActionState extends ProfileState {}

class ProfileInitial extends ProfileState {}

class FatchProfileInfoLoadingState extends ProfileState {}

class FatchProfileInfoSuccessState extends ProfileState {
  final profileInfo;

  FatchProfileInfoSuccessState({required this.profileInfo});
}
