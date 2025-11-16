import 'package:dartz/dartz.dart';
import 'package:task/core/error_handle/app_exception.dart';

import '../../model/user_model.dart';

abstract class UserRepo {
  Future<Either<AppException, UserModel>> getUserData(String userId);
  Future<Either<AppException, String>> createUser({
    required UserModel user,
    required String password,
  });
  Future<Either<AppException, List<UserModel>>> getUsers();
  Future<Either<AppException, void>> deleteUser(UserModel userModel);
}
