import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/RegisterScreen/Repo/RegisterRepo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<SendOtpEvent>(sendOtpEvent);
    on<SigninWithGoogleEvent>(signinWithGoogleEvent);
  }

  FutureOr<void> sendOtpEvent(
      SendOtpEvent event, Emitter<RegisterState> emit) async {
    await RegisterRepo.sendOtpFunction(event.phoneNumber);

    emit(SendOtpSuccessState());
  }

  FutureOr<void> signinWithGoogleEvent(
      SigninWithGoogleEvent event, Emitter<RegisterState> emit) async {
    var user = await RegisterRepo.signInWithGoogle();
    if (user?.uid != null) {
      emit(LogInSuccessState());
    }
  }
}
