import 'package:task/core/error_handle/error_type.dart';

import '../../../../../core/error_handle/app_exception.dart';
import '../../../../../core/helpers/shared_pref_helper.dart';
import '../../../../../core/utils/git_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auth_repo/auth_repo.dart';
import '../../../data/repo/user_repo/user_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthRepo _authRepo = getIt<AuthRepo>();
  final UserRepo _userRepo = getIt<UserRepo>();

  Future<void> login({required String email, required String password}) async {
    AppException? exception = validateInputs(email: email, password: password);

    if (exception != null) {
      emit(LoginFailure(appException: exception, isValidationError: true));
      return;
    }

    emit(LoginLoading());
    final result = await _authRepo.login(email: email, password: password);
    result.fold(
      (failure) {
        emit(LoginFailure(appException: failure, isValidationError: false));
      },
      (userId) async {
        final userRepoResult = await _userRepo.getUserData(userId);
        userRepoResult.fold(
          (f) {
            SharedPrefsHelper.logOut();
            emit(LoginFailure(appException: f, isValidationError: false));
          },
          (user) async {
            await SharedPrefsHelper.setUserModel(user);
            emit(LoginSuccess());
          },
        );
      },
    );
  }

  AppException? validateInputs({
    required String email,
    required String password,
  }) {
    Map<String, ErrorType> errors = {};
    // Email empty
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty) {
      errors['email'] = ErrorType.emailIsEmpty;
    }
    // Email format
    else if (!emailRegex.hasMatch(email)) {
      errors['email'] = ErrorType.notValidEmail;
    }

    // Password empty
    if (password.isEmpty) {
      errors['password'] = ErrorType.passwordIsEmpty;
    } else if (password.length < 6) {
      errors['password'] = ErrorType.passwordLessThan6;
    }

    return errors.isEmpty ? null : AppException(errors);
  }
}
