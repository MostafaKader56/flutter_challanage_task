part of 'create_user_cubit.dart';

@immutable
sealed class CreateUserState {}

final class CreateUserInitial extends CreateUserState {}

final class CreateUserLoading extends CreateUserState {}

final class CreateUserFailure extends CreateUserState {
  final AppException exception;

  CreateUserFailure({required this.exception});
}

final class CreateUserSuccess extends CreateUserState {}
