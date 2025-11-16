part of 'get_users_cubit.dart';

@immutable
sealed class GetUsersState {}

final class GetUsersInitial extends GetUsersState {}

final class GetUsersLoading extends GetUsersState {}

final class GetUsersFailure extends GetUsersState {
  final AppException exception;

  GetUsersFailure({required this.exception});
}

final class GetUsersSuccess extends GetUsersState {
  final List<UserModel> users;

  GetUsersSuccess({required this.users});
}
