import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';

import 'core/utils/git_it.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/utils/app_bloc_observer.dart';
import 'core/utils/app_router.dart';
import 'core/manager/localization_cubit/localization_cubit.dart';
import 'core/manager/theme_cubit/theme_cubit.dart';
import 'core/utils/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefsHelper.init();
  setupDependencyInjection();
  Bloc.observer = AppBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalizationCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

// Your gradient colors
const Color primaryGradientStart = Color(0xFF07B455);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, localizationState) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            if (localizationState is ChangeAppLanguage &&
                themeState is ThemeChanged) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: themeState.isDarkMode
                      ? Color(0xFF263238)
                      : Color(0xFFECEFF1),
                  // statusBarColor: themeState.isDarkMode
                  //     ? Color(0xFF0D1B2A)
                  //     : Color(0xFFECEFF1),
                  // statusBarColor: themeState.isDarkMode
                  //     ? Colors.black
                  //     : Colors.white,
                  statusBarIconBrightness: themeState.isDarkMode
                      ? Brightness.light
                      : Brightness.dark,
                ),
                child: MaterialApp.router(
                  locale: Locale(localizationState.languageCode),
                  localizationsDelegates: [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  routerConfig: AppRouter.router,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: true,
                    fontFamily: "Cairo",
                    // fontFamily: localizationState.fontFamily,
                    brightness: Brightness.light,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Color(0xFF07B455),
                      brightness: Brightness.light,
                      surface: Colors.white,
                    ),
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF1A1A1A),
                      elevation: 0,
                      centerTitle: true,
                    ),
                    cardTheme: CardThemeData(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGradientStart,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  darkTheme: ThemeData(
                    fontFamily: localizationState.fontFamily,
                    useMaterial3: true,
                    brightness: Brightness.dark,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Color(0xFF07B455),
                      brightness: Brightness.dark,
                    ),
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Color(0xFF1E1E1E),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      centerTitle: true,
                    ),
                    cardTheme: CardThemeData(
                      color: const Color(0xFF2A2A2A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGradientStart,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  themeMode: themeState.isDarkMode
                      ? ThemeMode.dark
                      : ThemeMode.light,
                ),
              );
            }
            return MaterialApp.router(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}

void printLogs(dynamic message, {String title = 'AppLogs'}) {
  log(message.toString(), name: title);
}
