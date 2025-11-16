part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

class ThemeChanged extends ThemeState {
  final bool isDarkMode;

  ThemeChanged({required this.isDarkMode});
}
