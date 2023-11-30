part of 'forgot_password_bloc.dart';

class ForgotPasswordState {
  ForgotPasswordState({
    required this.password,
    required this.confirmPassword,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.failureOption,
    required this.status,
  });

  final String password;
  final String confirmPassword;

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  final Option<AuthFailure> failureOption;
  final LoadStatus status;

  factory ForgotPasswordState.initial() => ForgotPasswordState(
        password: '',
        confirmPassword: '',
        isPasswordVisible: false,
        isConfirmPasswordVisible: false,
        failureOption: none(),
        status: LoadStatus.initial,
      );

  ForgotPasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    Option<AuthFailure>? failureOption,
    LoadStatus? status,
  }) {
    return ForgotPasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      failureOption: failureOption ?? this.failureOption,
      status: status ?? this.status,
    );
  }
}
