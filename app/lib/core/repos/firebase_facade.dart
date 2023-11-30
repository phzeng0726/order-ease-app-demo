import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/repos/i_firebase_facade.dart';
import 'package:ordering_system_client_app/http.dart';

class FirebaseFacade implements IFirebaseFacade {
  final firebase = auth.FirebaseAuth.instance;

  @override
  Future<Either<AuthFailure, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUid = credential.user?.uid ?? '';

      return right(firebaseUid);
    } on auth.FirebaseAuthException catch (e) {
      logger.e(e.code);
      if (e.code == 'invalid-credential') {
        return left(AuthFailure.wrongPassword());
      } else {
        return left(AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, String>> signInAnonymously() async {
    try {
      final credential = await firebase.signInAnonymously();
      final firebaseUid = credential.user?.uid ?? '';

      return right(firebaseUid);
    } on auth.FirebaseAuthException catch (e) {
      logger.e(e.code);
      switch (e.code) {
        case 'operation-not-allowed':
          print("Anonymous auth hasn't been enabled for this project.");
          return left(AuthFailure.operationNotAllowed());

        default:
          print('Unknown error.');
          return left(AuthFailure.unexpected());
      }
    }
  }

  @override
  Future<Option<AuthFailure>> deleteAnonymousUser() async {
    try {
      User? user = firebase.currentUser;

      if (user != null && user.isAnonymous) {
        await user.delete();
      } else {
        logger.w('Empty anonymous user');
      }

      return none();
    } on auth.FirebaseAuthException catch (e) {
      logger.e(e.code);
      switch (e.code) {
        case 'operation-not-allowed':
          print("Anonymous auth hasn't been enabled for this project.");
          return some(AuthFailure.operationNotAllowed());

        default:
          print('Unknown error.');
          return some(AuthFailure.unexpected());
      }
    }
  }

  @override
  Future<void> logOut() async {
    await firebase.signOut();
  }
}
