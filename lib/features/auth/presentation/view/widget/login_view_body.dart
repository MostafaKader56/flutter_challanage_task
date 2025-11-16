import 'package:task/core/error_handle/ui_error_handler.dart';
import 'package:task/main.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widget/custom_input_field.dart';
import '../../manager/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widget/app_main_btn.dart';
import '../../../../../core/widget/custom_password_input_field.dart';
import '../../../../../generated/l10n.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        switch (state) {
          case LoginInitial():
            break;
          case LoginLoading():
            Functions.showLoadingDialog();
            break;
          case LoginSuccess():
            GoRouter.of(context).go(AppRouter.kHomeView);
            break;
          case LoginFailure():
            printLogs(state.appException.originalError);
            if (!state.isValidationError) {
              GoRouter.of(context).pop();
            }
            break;
        }
      },
      builder: (BuildContext context, LoginState state) {
        if (state is LoginFailure) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/app_icon.png",
                          width: SizeConfig.screenWidth * .5,
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 2),
                    Text(
                      S.of(context).login,
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 0.5),
                    Text(
                      S.of(context).welcome_back,
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 3),
                    CustomInputField(
                      label: S.of(context).email,
                      hint: S.of(context).email_hint,
                      controller: emailController,
                      error: state.appException.errorType["email"] != null
                          ? UIErrorHandler.getLocalizedMessage(
                              state.appException.errorType["email"]!,
                              context,
                            )
                          : null,
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 2),
                    CustomPasswordInputField(
                      label: S.of(context).password,
                      hint: S.of(context).password_hint,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      error: state.appException.errorType["password"] != null
                          ? UIErrorHandler.getLocalizedMessage(
                              state.appException.errorType["password"]!,
                              context,
                            )
                          : null,
                    ),
                    SizedBox(height: SizeConfig.defaultSize * 3),
                    AppMainButton(
                      theme: theme,
                      onPressed: _handleLogin,
                      label: S.of(context).login,
                    ),
                    SizedBox(height: SizeConfig.defaultSize),
                  ],
                ),
              ),
            ),
          );
        }

        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/app_icon.png",
                        width: SizeConfig.screenWidth * .5,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  Text(
                    S.of(context).login,
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 0.5),
                  Text(
                    S.of(context).welcome_back,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 3),
                  CustomInputField(
                    label: S.of(context).email,
                    hint: S.of(context).email_hint,
                    controller: emailController,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  CustomPasswordInputField(
                    label: S.of(context).password,
                    hint: S.of(context).password_hint,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 3),
                  AppMainButton(
                    theme: theme,
                    onPressed: _handleLogin,
                    label: S.of(context).login,
                  ),
                  SizedBox(height: SizeConfig.defaultSize),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleLogin() {
    BlocProvider.of<LoginCubit>(context).login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
