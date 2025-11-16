import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/error_handle/app_exception.dart';
import 'package:task/features/auth/data/model/user_model.dart';

import '../../../../../core/utils/git_it.dart';
import '../../../../auth/data/repo/user_repo/user_repo.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit() : super(CreateUserInitial());

  final UserRepo _userRepo = getIt<UserRepo>();

  Future<void> createUser({
    required UserModel user,
    required String password,
  }) async {
    emit(CreateUserLoading());
    final result = await _userRepo.createUser(user: user, password: password);
    result.fold(
      (left) {
        emit(CreateUserFailure(exception: left));
      },
      (right) {
        emit(CreateUserSuccess());
      },
    );
  }
}
