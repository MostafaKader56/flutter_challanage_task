import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task/features/home/presentation/manager/create_user_cubit/create_user_cubit.dart';
import 'package:task/features/products_page/presentation/manager/delete_product_cubit/delete_product_cubit.dart';
import 'package:task/features/products_page/presentation/manager/get_products_cubit/get_products_cubit.dart';
import 'package:task/features/products_page/presentation/manager/update_product_cubit/update_product_cubit.dart';
import 'package:task/features/products_page/presentation/view/products_page.dart';
import 'package:task/features/users_page/presentation/manager/delete_user_cubit/delete_user_cubit.dart';
import 'package:task/features/users_page/presentation/manager/get_users_cubit/get_users_cubit.dart';
import 'package:task/features/users_page/presentation/view/users_page.dart';

import '../../features/auth/presentation/manager/login_cubit/login_cubit.dart';
import '../../features/auth/presentation/view/login_view.dart';
import '../../features/home/presentation/manager/create_product_cubit/create_product_cubit.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/splash/presentation/view/onboarding_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/kOnBoardingView';
  static const kHomeView = '/kHomeView';
  static const kLoginView = '/kLoginView';
  static const kUsersView = '/kUsersView';
  static const kProductsView = '/kProductsView';

  Duration animationDuration = const Duration(milliseconds: 300);
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: SplashView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kOnBoardingView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: const OnboardingView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => CreateUserCubit()),
                BlocProvider(create: (context) => CreateProductCubit()),
              ],
              child: HomeView(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kLoginView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => LoginCubit(),
              child: LoginView(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kUsersView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => GetUsersCubit()),
                BlocProvider(create: (context) => DeleteUserCubit()),
              ],
              child: UsersPage(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: kProductsView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 400),
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => UpdateProductCubit()),
                BlocProvider(create: (context) => DeleteProductCubit()),
                BlocProvider(create: (context) => GetProductsCubit()),
              ],
              child: ProductsPage(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(
                      curve: Curves.easeInOutCirc,
                    ).animate(animation),
                    child: child,
                  );
                },
          );
        },
      ),
    ],
  );
}
