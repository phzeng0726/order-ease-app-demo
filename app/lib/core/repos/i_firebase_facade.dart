import 'package:dartz/dartz.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';

abstract class IFirebaseFacade {
  Future<Either<AuthFailure, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, String>> signInAnonymously();

  Future<Option<AuthFailure>> deleteAnonymousUser();

  Future<void> logOut();
}
