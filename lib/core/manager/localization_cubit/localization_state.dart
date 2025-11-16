part of 'localization_cubit.dart';

@immutable
sealed class LocalizationState {}

final class LocalizationInitial extends LocalizationState {}

class ChangeAppLanguage extends LocalizationState {
  final String languageCode;
  final String fontFamily;

  ChangeAppLanguage({required this.languageCode, required this.fontFamily});
}
