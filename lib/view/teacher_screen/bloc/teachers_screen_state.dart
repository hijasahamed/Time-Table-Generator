part of 'teachers_screen_bloc.dart';

@immutable
sealed class TeachersScreenState {}

final class TeachersScreenInitial extends TeachersScreenState {}

class DeleteTeacherCircularIndicatorState extends TeachersScreenState {}

class DeleteTeacherCircularIndicatorStopState extends TeachersScreenState {}