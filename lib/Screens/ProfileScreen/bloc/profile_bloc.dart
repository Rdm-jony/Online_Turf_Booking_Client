import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/ProfileInfoScreen/bloc/profile_info_bloc.dart';
import 'package:playspot_client/Screens/ProfileScreen/Repo/ProfileRepo.dart';
import 'package:playspot_client/Screens/TurfOwner/Dashboard/Repo/DashboardRepo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FatchProfileInfoEvent>(fatchProfileInfoEvent);
    on<UploadProfilePhotoEvent>(uploadProfilePhotoEvent);
  }

  FutureOr<void> fatchProfileInfoEvent(
      FatchProfileInfoEvent event, Emitter<ProfileState> emit) async {
    emit(FatchProfileInfoLoadingState());
    var profileInfo = await ProfileRepo.fatchProfileInfo();
    emit(FatchProfileInfoSuccessState(profileInfo: profileInfo));
  }

  FutureOr<void> uploadProfilePhotoEvent(
      UploadProfilePhotoEvent event, Emitter<ProfileState> emit) async {
    var imageUrl = await DashboardRepo.uploadTurfLogo(event.imagePath);
    if (imageUrl != "") {
      bool isUpload = await ProfileRepo.uploadImageToDb({"image": imageUrl});
      if (isUpload) {
        var user = FirebaseAuth.instance.currentUser;
        await user?.updatePhotoURL(imageUrl);

        var profileInfo = await ProfileRepo.fatchProfileInfo();
        emit(FatchProfileInfoSuccessState(profileInfo: profileInfo));
      }
    }
  }
}
