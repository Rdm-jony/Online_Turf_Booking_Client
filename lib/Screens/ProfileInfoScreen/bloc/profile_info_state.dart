part of 'profile_info_bloc.dart';

@immutable
abstract class ProfileInfoState {}
abstract class ProfileInfoActionState extends ProfileInfoState{}

 class ProfileInfoInitial extends ProfileInfoState {}
 class ProfileInfoSuccessState extends ProfileInfoActionState{}

