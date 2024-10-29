import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<HomeScreenEvent>((event, emit) {

    });
    on<AddingButtonCircularIndicatorEvent>(addingButtonCircularIndicatorEvent);
    on<AddingButtonCircularIndicatorStopEvent>(addingButtonCircularIndicatorStopEvent);
  }

  FutureOr<void> addingButtonCircularIndicatorEvent(
    AddingButtonCircularIndicatorEvent event, Emitter<HomeScreenState> emit) {
      emit(AddingButtonCircularIndicatorState());
  }

  FutureOr<void> addingButtonCircularIndicatorStopEvent(
    AddingButtonCircularIndicatorStopEvent event, Emitter<HomeScreenState> emit) {
      emit(AddingButtonCircularIndicatorStopState());
  }
}
