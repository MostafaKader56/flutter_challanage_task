import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/helpers/shared_pref_helper.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/l10n.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        _openNextScreen();
      }
    });
  }

  void _openNextScreen() {
    if (SharedPrefsHelper.isOnboardingViewed()) {
      if (SharedPrefsHelper.isLoggedIn()) {
        GoRouter.of(context).go(AppRouter.kHomeView);
      } else {
        GoRouter.of(context).go(AppRouter.kLoginView);
      }
    } else {
      GoRouter.of(context).go(AppRouter.kOnBoardingView);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Icon
                    Image.asset(
                      'assets/images/app_icon.png',
                      width: SizeConfig.defaultSize * 10,
                      height: SizeConfig.defaultSize * 10,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: SizeConfig.defaultSize * 3),

                    Text(
                      S.of(context).app_name,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                      ),
                    ),

                    SizedBox(height: SizeConfig.defaultSize),

                    Text(
                      S.of(context).splash_subtitle,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: SizeConfig.defaultSize * 7),

                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.primary,
                        ),
                      ),
                    ),

                    SizedBox(height: SizeConfig.defaultSize * 2),

                    Text(
                      S.of(context).loading,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
