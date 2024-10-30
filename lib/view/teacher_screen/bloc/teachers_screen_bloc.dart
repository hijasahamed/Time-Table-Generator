import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'teachers_screen_event.dart';
part 'teachers_screen_state.dart';

class TeachersScreenBloc extends Bloc<TeachersScreenEvent, TeachersScreenState> {
  TeachersScreenBloc() : super(TeachersScreenInitial()) {
    on<TeachersScreenEvent>((event, emit) {
      
    });
    on<DeleteTeacherCircularIndicatorEvent>(deleteTeacherCircularIndicatorEvent);
    on<DeleteTeacherCircularIndicatorStopEvent>(deleteTeacherCircularIndicatorStopEvent);
  }

  FutureOr<void> deleteTeacherCircularIndicatorEvent(
    DeleteTeacherCircularIndicatorEvent event, Emitter<TeachersScreenState> emit) {
      emit(DeleteTeacherCircularIndicatorState());
  }

  FutureOr<void> deleteTeacherCircularIndicatorStopEvent(
    DeleteTeacherCircularIndicatorStopEvent event, Emitter<TeachersScreenState> emit) {
      emit(DeleteTeacherCircularIndicatorStopState());
  }
}
