import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:task/core/error_handle/app_exception.dart';

import 'package:task/features/auth/data/model/user_model.dart';

import '../../../../../core/error_handle/error_type.dart';
import 'user_repo.dart';

class UserRepoImpl implements UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Either<AppException, UserModel>> getUserData(String userId) async {
    try {
      final doc = await _firestore
          .collection("New Challange Users")
          .doc(userId)
          .get();

      if (!doc.exists) {
        return Left(
          AppException({
            "email": ErrorType.unexpectedError,
          }, originalMessage: "User not found"),
        );
      }

      return Right(UserModel.fromJson(doc.data()!));
    } on FirebaseException catch (e) {
      return Left(
        AppException(
          {"email": ErrorType.unexpectedError},
          originalMessage: e.message,
          originalError: e,
        ),
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

  @override
  Future<Either<AppException, String>> createUser({
    required UserModel user,
    required String password,
  }) async {
    try {
      // Create account
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );

      // Save user to Firestore
      await _firestore
          .collection("New Challange Users")
          .doc(credential.user!.uid)
          .set(user.toJson());

      return Right(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      // Map Firebase errors to your AppException errors
      late Map<String, ErrorType> errorMap;

      switch (e.code) {
        case 'invalid-email':
          errorMap = {'email': ErrorType.invalidEmailFirebase};
          break;

        case 'email-already-in-use':
          errorMap = {'email': ErrorType.invalidCredential};
          break;

        case 'weak-password':
          errorMap = {'password': ErrorType.passwordLessThan6};
          break;

        case 'user-not-found':
          errorMap = {'email': ErrorType.userNotFound};
          break;

        case 'wrong-password':
          errorMap = {'password': ErrorType.wrongPassword};
          break;

        case 'user-disabled':
          errorMap = {'email': ErrorType.userDisabled};
          break;

        case 'too-many-requests':
          errorMap = {'auth': ErrorType.tooManyRequests};
          break;

        default:
          errorMap = {'auth': ErrorType.unexpectedError};
      }

      return Left(
        AppException(errorMap, originalMessage: e.message, originalError: e),
      );
    } catch (e) {
      // Non-Firebase unexpected error
      return Left(
        AppException(
          {'auth': ErrorType.unexpectedError},
          originalMessage: e.toString(),
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<UserModel>>> getUsers() async {
    try {
      final snapshot = await _firestore.collection("New Challange Users").get();

      final users = snapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();

      return Right(users);
    } on FirebaseException catch (e) {
      // Handle Firestore-specific errors
      late Map<String, ErrorType> errorMap;

      switch (e.code) {
        case 'permission-denied':
          errorMap = {
            'auth': ErrorType.userDisabled,
          }; // or a new type like ErrorType.permissionDenied
          break;
        case 'unavailable':
          errorMap = {'network': ErrorType.unexpectedError}; // example mapping
          break;
        default:
          errorMap = {'users': ErrorType.unexpectedError};
      }

      return Left(
        AppException(errorMap, originalMessage: e.message, originalError: e),
      );
    } catch (e) {
      // Non-Firebase unexpected errors
      return Left(
        AppException(
          {'users': ErrorType.unexpectedError},
          originalMessage: e.toString(),
          originalError: e,
        ),
      );
    }
  }

  @override
  Future<Either<AppException, void>> deleteUser(UserModel userModel) async {
    try {
      final snapshot = _firestore.collection("New Challange Users");

      QuerySnapshot querySnapshot = await snapshot
          .where('email', isEqualTo: userModel.email)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      return Right(null);
    } on FirebaseException catch (e) {
      // Handle Firestore-specific errors
      late Map<String, ErrorType> errorMap;

      switch (e.code) {
        case 'permission-denied':
          errorMap = {
            'auth': ErrorType.userDisabled,
          }; // or a new type like ErrorType.permissionDenied
          break;
        case 'unavailable':
          errorMap = {'network': ErrorType.unexpectedError}; // example mapping
          break;
        default:
          errorMap = {'users': ErrorType.unexpectedError};
      }

      return Left(
        AppException(errorMap, originalMessage: e.message, originalError: e),
      );
    } catch (e) {
      // Non-Firebase unexpected errors
      return Left(
        AppException(
          {'users': ErrorType.unexpectedError},
          originalMessage: e.toString(),
          originalError: e,
        ),
      );
    }
  }
}
