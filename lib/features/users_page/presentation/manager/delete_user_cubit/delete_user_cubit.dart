import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/auth/data/model/user_model.dart';

import '../../../../../core/error_handle/app_exception.dart';
import '../../../../../core/utils/git_it.dart';
import '../../../../auth/data/repo/user_repo/user_repo.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit() : super(DeleteUserInitial());

  final UserRepo _usersRepo = getIt<UserRepo>();

  Future<void> deleteUser(UserModel userModel) async {
    emit(DeleteUserLoading());
    final result = await _usersRepo.deleteUser(userModel);
    result.fold(
      (left) {
        emit(DeleteUserFailure(exception: left));
      },
      (right) {
        emit(DeleteUserSuccess());
      },
    );
  }
}
