import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/error_handle/error_type.dart';
import 'package:task/core/error_handle/ui_error_handler.dart';
import 'package:task/core/helpers/shared_pref_helper.dart';
import 'package:task/core/manager/localization_cubit/localization_cubit.dart';
import 'package:task/core/manager/theme_cubit/theme_cubit.dart';
import 'package:task/core/utils/app_router.dart';
import 'package:task/core/utils/functions.dart';
import 'package:task/features/home/data/model/product_model.dart';
import 'package:task/features/home/presentation/manager/create_product_cubit/create_product_cubit.dart';
import 'package:task/features/home/presentation/manager/create_user_cubit/create_user_cubit.dart';
import 'package:task/features/home/presentation/view/widget/add_user_btm_sheet.dart';

import '../../../../../core/widget/app_check_box_component.dart';
import '../../../../../generated/l10n.dart';
import 'add_product_btm_sheet.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateUserCubit, CreateUserState>(
          listener: (context, state) {
            switch (state) {
              case CreateUserInitial():
                break;
              case CreateUserLoading():
                Functions.showLoadingDialog();
                break;
              case CreateUserSuccess():
                Functions.showSnackBar(S.of(context).done);
                GoRouter.of(context).pop();
                break;
              case CreateUserFailure():
                final MapEntry<String, ErrorType>? error =
                    state.exception.errorType.entries.isNotEmpty
                    ? state.exception.errorType.entries.first
                    : null;
                if (error != null) {
                  Functions.showSnackBar(
                    UIErrorHandler.getLocalizedMessage(error.value, context),
                  );
                }
                GoRouter.of(context).pop();
                break;
            }
          },
        ),
        BlocListener<CreateProductCubit, CreateProductState>(
          listener: (context, state) {
            switch (state) {
              case CreateProductInitial():
                break;
              case CreateProductLoading():
                Functions.showLoadingDialog();
                break;
              case CreateProductSuccess():
                Functions.showSnackBar(S.of(context).done);
                GoRouter.of(context).pop();
                break;
              case CreateProductFailure():
                final MapEntry<String, ErrorType>? error =
                    state.exception.errorType.entries.isNotEmpty
                    ? state.exception.errorType.entries.first
                    : null;
                if (error != null) {
                  Functions.showSnackBar(
                    UIErrorHandler.getLocalizedMessage(error.value, context),
                  );
                }
                GoRouter.of(context).pop();
                break;
            }
          },
        ),
      ],
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...(SharedPrefsHelper.getUserModel()?.type == 'admin')
                    ? [
                        ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic>? result =
                                await Functions.showCustomBottomSheet(
                                  AddUserBottomSheet(),
                                );

                            if (result != null && context.mounted) {
                              BlocProvider.of<CreateUserCubit>(
                                context,
                              ).createUser(
                                user: result["user"],
                                password: result['password'],
                              );
                            }
                          },
                          child: Text(S.of(context).add_user),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.kUsersView);
                          },
                          child: Text(S.of(context).view_users),
                        ),
                      ]
                    : [Container()],
                ElevatedButton(
                  onPressed: () async {
                    final ProductModel? productModel =
                        await Functions.showCustomBottomSheet(
                          AddProductBottomSheet(),
                        );

                    if (productModel != null && context.mounted) {
                      BlocProvider.of<CreateProductCubit>(
                        context,
                      ).createProduct(productModel);
                    }
                  },
                  child: Text(S.of(context).add_product),
                ),
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kProductsView);
                  },
                  child: Text(S.of(context).view_products),
                ),

                TextButton(
                  onPressed: () {
                    BlocProvider.of<LocalizationCubit>(context).changeLanguage(
                      languageCode:
                          SharedPrefsHelper.getLanguageSuffix() == 'ar'
                          ? 'en'
                          : 'ar',
                    );
                  },
                  child: Text(S.of(context).otherlanguage),
                ),
                AppCheckBoxComponent(
                  text: S.of(context).dark_mode,
                  initialValue: SharedPrefsHelper.getIsDarkMode(),
                  onChanged: (value) {
                    BlocProvider.of<ThemeCubit>(context).toggleTheme();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    SharedPrefsHelper.logOut();
                    GoRouter.of(context).go(AppRouter.kLoginView);
                  },
                  child: Text(S.of(context).logout),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
