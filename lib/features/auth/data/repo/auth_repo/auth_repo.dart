import 'package:dartz/dartz.dart';

import '../../../../../core/error_handle/app_exception.dart';

abstract class AuthRepo {
  Future<Either<AppException, String>> login({
    required String email,
    required String password,
  });
}
