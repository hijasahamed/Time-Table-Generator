part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

class AddingButtonCircularIndicatorEvent extends HomeScreenEvent {}
class AddingButtonCircularIndicatorStopEvent extends HomeScreenEvent {}