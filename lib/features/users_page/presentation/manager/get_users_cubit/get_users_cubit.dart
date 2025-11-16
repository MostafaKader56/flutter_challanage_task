import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/error_handle/app_exception.dart';
import 'package:task/core/utils/git_it.dart';
import 'package:task/features/auth/data/model/user_model.dart';
import 'package:task/features/auth/data/repo/user_repo/user_repo.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit() : super(GetUsersInitial());

  final UserRepo _usersRepo = getIt<UserRepo>();

  Future<void> getUsers() async {
    emit(GetUsersLoading());
    final result = await _usersRepo.getUsers();
    result.fold(
      (left) {
        emit(GetUsersFailure(exception: left));
      },
      (right) {
        emit(GetUsersSuccess(users: right));
      },
    );
  }
}
