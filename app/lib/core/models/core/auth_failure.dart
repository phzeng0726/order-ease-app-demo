import 'package:equatable/equatable.dart';

class AuthFailure extends Equatable {
  const AuthFailure({
    this.message,
  });
  final String? message;

  factory AuthFailure.empty() => const AuthFailure();

  factory AuthFailure.operationNotAllowed() => const AuthFailure(
        message: "Anonymous auth hasn't been enabled for this project.",
      );

  factory AuthFailure.invalidEmail() => const AuthFailure(
        message: 'Invalid email',
      );

  factory AuthFailure.wrongPassword() => const AuthFailure(
        message: 'Wrong Password',
      );

  factory AuthFailure.emailNotFoundInDatabase() => const AuthFailure(
        message: 'User email not found',
      );

  factory AuthFailure.uidNotFoundInDatabase() => const AuthFailure(
        message: 'Firebase uid not found',
      );

  factory AuthFailure.serverError() => const AuthFailure(
        message: 'Server Error',
      );

  factory AuthFailure.unexpected() => const AuthFailure(
        message: 'Unexpected Error',
      );

  @override
  String toString() {
    return 'AuthFailure: $message';
  }

  @override
  List<Object?> get props => [message];
}
