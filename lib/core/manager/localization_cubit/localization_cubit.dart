import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/shared_pref_helper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial()) {
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final languageCode = SharedPrefsHelper.getLanguageSuffix();
    String fontFamily = "Cairo";
    if (languageCode == "ar") {
      fontFamily = "Cairo";
    }
    emit(ChangeAppLanguage(languageCode: languageCode, fontFamily: fontFamily));
  }

  Future<void> changeLanguage({required String languageCode}) async {
    String oldLanguageCode = SharedPrefsHelper.getLanguageSuffix();
    if (oldLanguageCode == languageCode) {
      return;
    }
    await SharedPrefsHelper.setLanguageSuffix(languageCode);
    String fontFamily = "Poppins";
    if (languageCode == "ar") {
      fontFamily = "Cairo";
    }
    emit(ChangeAppLanguage(languageCode: languageCode, fontFamily: fontFamily));
  }
}
