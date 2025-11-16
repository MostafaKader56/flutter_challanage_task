import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/shared_pref_helper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    _loadSavedTheme();
  }

  void _loadSavedTheme() {
    final isDarkMode = SharedPrefsHelper.getIsDarkMode();
    emit(ThemeChanged(isDarkMode: isDarkMode));
  }

  Future<void> toggleTheme() async {
    final currentState = state;
    if (currentState is ThemeChanged) {
      final newIsDarkMode = !currentState.isDarkMode;
      await SharedPrefsHelper.setIsDarkMode(newIsDarkMode);
      emit(ThemeChanged(isDarkMode: newIsDarkMode));
    }
  }
}
