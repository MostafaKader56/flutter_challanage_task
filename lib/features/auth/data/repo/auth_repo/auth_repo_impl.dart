import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:task/core/error_handle/app_exception.dart';

import '../../../../../core/error_handle/error_type.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<AppException, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final auth = FirebaseAuth.instance;

      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(result.user!.uid);
    } on FirebaseAuthException catch (e) {
      final errorType = mapFirebaseError(e.code);

      return Left(
        AppException(errorType, originalMessage: e.message, originalError: e),
      );
    } catch (e) {
      return Left(
        AppException(
          {"email": ErrorType.unexpectedError},
          originalMessage: e.toString(),
          originalError: e,
        ),
      );
    }
  }

  Map<String, ErrorType> mapFirebaseError(String code) {
    switch (code) {
      case "user-not-found":
        return {"email": ErrorType.userNotFound};

      case "wrong-password":
        return {"password": ErrorType.wrongPassword};

      case "invalid-email":
        return {"email": ErrorType.invalidEmailFirebase};

      case "user-disabled":
        return {"email": ErrorType.userDisabled};

      case "invalid-credential":
        return {"email": ErrorType.invalidCredential};

      case "too-many-requests":
        return {"email": ErrorType.tooManyRequests};

      default:
        return {"email": ErrorType.unexpectedError};
    }
  }
}
