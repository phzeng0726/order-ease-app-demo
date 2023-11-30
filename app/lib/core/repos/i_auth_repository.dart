import 'package:dartz/dartz.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/user_data.dart';

abstract class IAuthRepository {
  // Sign in
  Future<Either<AuthFailure, String>> getUserIdByEmail({
    required String email,
  });

  Future<Either<AuthFailure, UserData>> getUserFromDatabase({
    required String firebaseUid,
  });

  // Sign Up
  Future<Option<AuthFailure>> createOTP({
    required String email,
    required String token,
  });

  Future<Option<AuthFailure>> verifyOTP({
    required String token,
    required String otpCode,
  });

  Future<Option<AuthFailure>> createUser({
    required UserData user,
    required String password,
  });

  // Others
  Future<Option<AuthFailure>> resetPassword({
    required String userId,
    required String password,
  });

  Future<Option<AuthFailure>> deleteUser({
    required String userId,
  });
}
