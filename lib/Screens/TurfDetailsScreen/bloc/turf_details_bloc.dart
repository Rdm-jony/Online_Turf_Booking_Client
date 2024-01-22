import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'turf_details_event.dart';
part 'turf_details_state.dart';

class TurfDetailsBloc extends Bloc<TurfDetailsEvent, TurfDetailsState> {
  TurfDetailsBloc() : super(TurfDetailsInitial()) {
    on<NavigateToPricingScreenEvent>(navigateToPricingScreenEvent);
  }

  FutureOr<void> navigateToPricingScreenEvent(
      NavigateToPricingScreenEvent event, Emitter<TurfDetailsState> emit) {
    emit(NavigateToPricingScreenState());
  }
}
