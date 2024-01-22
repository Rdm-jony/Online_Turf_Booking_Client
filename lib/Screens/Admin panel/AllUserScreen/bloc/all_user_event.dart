part of 'all_user_bloc.dart';

@immutable
abstract class AllUserEvent {}

class FatchAllUserEvent extends AllUserEvent {}

class SetUserRoleEvent extends AllUserEvent {
  final userRole;
  final email;

  SetUserRoleEvent({required this.userRole,required this.email});
}
