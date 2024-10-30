part of 'teachers_screen_bloc.dart';

@immutable
sealed class TeachersScreenEvent {}

class DeleteTeacherCircularIndicatorEvent extends TeachersScreenEvent {}

class DeleteTeacherCircularIndicatorStopEvent extends TeachersScreenEvent {}