import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

class OnboardingModel {
  final String imagePath;
  final String Function(BuildContext) getTitle;
  final String Function(BuildContext) getDescription;

  OnboardingModel({
    required this.imagePath,
    required this.getTitle,
    required this.getDescription,
  });
}

// Sample onboarding data
final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    imagePath: 'assets/images/onboarding_1.png',
    getTitle: (context) => S.of(context).onboarding1Title,
    getDescription: (context) => S.of(context).onboarding1Description,
  ),
  OnboardingModel(
    imagePath: 'assets/images/onboarding_2.png',
    getTitle: (context) => S.of(context).onboarding2Title,
    getDescription: (context) => S.of(context).onboarding2Description,
  ),
  OnboardingModel(
    imagePath: 'assets/images/onboarding_3.png',
    getTitle: (context) => S.of(context).onboarding3Title,
    getDescription: (context) => S.of(context).onboarding3Description,
  ),
  OnboardingModel(
    imagePath: 'assets/images/onboarding_4.png',
    getTitle: (context) => S.of(context).onboarding4Title,
    getDescription: (context) => S.of(context).onboarding4Description,
  ),
  OnboardingModel(
    imagePath: 'assets/images/onboarding_5.png',
    getTitle: (context) => S.of(context).onboarding5Title,
    getDescription: (context) => S.of(context).onboarding5Description,
  ),
];
