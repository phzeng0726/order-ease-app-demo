part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

// Auth
class ChangeForgotPasswordFormEvent extends ForgotPasswordEvent {
  const ChangeForgotPasswordFormEvent({
    this.password,
    this.confirmPassword,
  });

  final String? password;
  final String? confirmPassword;
}

class ChangePasswordVisibleEvent extends ForgotPasswordEvent {
  const ChangePasswordVisibleEvent();
}

class ChangeConfirmPasswordVisibleEvent extends ForgotPasswordEvent {
  const ChangeConfirmPasswordVisibleEvent();
}

class ResetPasswordEvent extends ForgotPasswordEvent {
  const ResetPasswordEvent({
    required this.userId,
  });

  final String userId;
}
