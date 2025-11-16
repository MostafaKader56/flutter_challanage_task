import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helpers/shared_pref_helper.dart';
import '../../../../../core/manager/localization_cubit/localization_cubit.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/onboarding_model.dart';
import 'onboarding_page.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingViewBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      SharedPrefsHelper.setOnboardingViewed(true);
      GoRouter.of(context).go(AppRouter.kLoginView);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      children: [
        // Language switcher
        Row(
          children: [
            TextButton(
              onPressed: () {
                BlocProvider.of<LocalizationCubit>(context).changeLanguage(
                  languageCode: SharedPrefsHelper.getLanguageSuffix() == "ar"
                      ? "en"
                      : "ar",
                );
              },
              child: Text(S.of(context).otherlanguage),
            ),
          ],
        ),

        // Main content area
        Expanded(
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                page: onboardingData[index],
                isLandscape: isLandscape,
              );
            },
          ),
        ),

        // Bottom section with divider and controls
        const Divider(),
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.defaultSize * 2,
            right: SizeConfig.defaultSize * 2,
            bottom: SizeConfig.defaultSize * (isLandscape ? 1 : 2),
            top: SizeConfig.defaultSize * 1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Page indicator
              Row(
                children: List.generate(
                  onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: SizeConfig.defaultSize * 0.85,
                    height: SizeConfig.defaultSize * 0.85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
              ),

              // Next button
              ElevatedButton(
                onPressed: _nextPage,
                child: Text(
                  _currentPage == onboardingData.length - 1
                      ? S.of(context).getStarted
                      : S.of(context).next,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
