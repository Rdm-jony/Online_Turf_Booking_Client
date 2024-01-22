import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/Admin%20panel/AllUserScreen/Repo/AllUserRepo.dart';

part 'all_user_event.dart';
part 'all_user_state.dart';

class AllUserBloc extends Bloc<AllUserEvent, AllUserState> {
  AllUserBloc() : super(AllUserInitial()) {
    on<FatchAllUserEvent>(fatchAllUserEvent);
    on<SetUserRoleEvent>(setUserRoleEvent);
  }

  FutureOr<void> fatchAllUserEvent(
      FatchAllUserEvent event, Emitter<AllUserState> emit) async {
    emit(FatchAllUserLoadingState());
    List allUser = await AllUserRepo.fatchAllUser();
    emit(FatchAllUserSuccessState(allUser: allUser));
  }

  FutureOr<void> setUserRoleEvent(
      SetUserRoleEvent event, Emitter<AllUserState> emit) async {
    bool isTrue = await AllUserRepo.setUserRole(event.userRole, event.email);
    if (isTrue) {
      List allUser = await AllUserRepo.fatchAllUser();
      emit(FatchAllUserSuccessState(allUser: allUser));
    }
  }
}
