import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playspot_client/Screens/RegisterScreen/Repo/RegisterRepo.dart';
import 'package:playspot_client/Screens/VerifyScreen/Repo/VerifyRepo.dart';

part 'verify_event.dart';
part 'verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  VerifyBloc() : super(VerifyInitial()) {
    on<VerifyNumberEvent>(verifyNumberEvent);
    on<ResendCodeEvent>(resendCodeEvent);
  }

  FutureOr<void> verifyNumberEvent(
      VerifyNumberEvent event, Emitter<VerifyState> emit) async {
    var user = await VerifyRepo.verifyNumberFunction(event.smsCode);
    if (user?.uid != null) {
      emit(VerifySuccessState());
    }
  }

  FutureOr<void> resendCodeEvent(
      ResendCodeEvent event, Emitter<VerifyState> emit) async {
    await RegisterRepo.sendOtpFunction(event.phoneNumber);
  }
}
