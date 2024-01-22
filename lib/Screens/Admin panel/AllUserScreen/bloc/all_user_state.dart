part of 'all_user_bloc.dart';

@immutable
abstract class AllUserState {}

abstract class AllUserActionState extends AllUserState {}

class AllUserInitial extends AllUserState {}

class FatchAllUserLoadingState extends AllUserState {}

class FatchAllUserSuccessState extends AllUserState {
  final allUser;

  FatchAllUserSuccessState({required this.allUser});
}
