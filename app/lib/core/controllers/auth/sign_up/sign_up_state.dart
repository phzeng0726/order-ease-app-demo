part of 'sign_up_bloc.dart';

class SignUpState {
  SignUpState({
    required this.password,
    required this.confirmPassword,
    required this.firstName,
    required this.lastName,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.failureOption,
    required this.status,
  });

  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  final Option<AuthFailure> failureOption;
  final LoadStatus status;

  factory SignUpState.initial() => SignUpState(
        password: '',
        confirmPassword: '',
        firstName: '',
        lastName: '',
        isPasswordVisible: false,
        isConfirmPasswordVisible: false,
        failureOption: none(),
        status: LoadStatus.initial,
      );

  SignUpState copyWith({
    String? password,
    String? confirmPassword,
    String? firstName,
    String? lastName,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    Option<AuthFailure>? failureOption,
    LoadStatus? status,
  }) {
    return SignUpState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      failureOption: failureOption ?? this.failureOption,
      status: status ?? this.status,
    );
  }
}
