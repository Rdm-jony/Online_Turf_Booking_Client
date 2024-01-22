import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/ProfileInfoScreen/Repo/ProfileInfoRepo.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  ProfileInfoBloc() : super(ProfileInfoInitial()) {
    on<SendUserInfoToDbEvent>(sendUserInfoToDbEvent);
  }

  FutureOr<void> sendUserInfoToDbEvent(
      SendUserInfoToDbEvent event, Emitter<ProfileInfoState> emit) async {
    bool isTrue =
        await ProfileInfoRepo.sendUserInfoToDbFunction(event.userInfo);
    print(isTrue);
    if (isTrue) {
      emit(ProfileInfoSuccessState());
    }
  }
}
