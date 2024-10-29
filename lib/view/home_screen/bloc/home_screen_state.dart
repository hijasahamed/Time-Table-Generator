part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

class AddingButtonCircularIndicatorState extends HomeScreenState {}
class AddingButtonCircularIndicatorStopState extends HomeScreenState {}
