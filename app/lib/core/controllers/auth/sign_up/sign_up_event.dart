part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {
  const SignUpEvent();
}

// Auth
class ChangeSignUpFormEvent extends SignUpEvent {
  const ChangeSignUpFormEvent({
    this.password,
    this.confirmPassword,
    this.firstName,
    this.lastName,
  });

  final String? password;
  final String? confirmPassword;
  final String? firstName;
  final String? lastName;
}

class ChangePasswordVisibleEvent extends SignUpEvent {
  const ChangePasswordVisibleEvent();
}

class ChangeConfirmPasswordVisibleEvent extends SignUpEvent {
  const ChangeConfirmPasswordVisibleEvent();
}

class CreateUserEvent extends SignUpEvent {
  const CreateUserEvent({
    required this.email,
    required this.languageId,
  });

  final String email;
  final int languageId;
}

class SignInFirebaseAfterCreatedEvent extends SignUpEvent {
  const SignInFirebaseAfterCreatedEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
