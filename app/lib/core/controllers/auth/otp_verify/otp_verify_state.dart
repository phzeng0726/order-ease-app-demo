part of 'otp_verify_bloc.dart';

class OTPVerifyState {
  OTPVerifyState({
    required this.token,
    required this.otpCode,
    required this.verifyAttempts,
    required this.failureOption,
    required this.status,
  });

  final String token;
  final String otpCode;
  int verifyAttempts;
  final Option<AuthFailure> failureOption;
  final LoadStatus status;

  factory OTPVerifyState.initial() => OTPVerifyState(
        token: const Uuid().v4(),
        otpCode: '',
        verifyAttempts: 0,
        failureOption: none(),
        status: LoadStatus.initial,
      );

  OTPVerifyState copyWith({
    String? token,
    String? otpCode,
    int? verifyAttempts,
    Option<AuthFailure>? failureOption,
    LoadStatus? status,
  }) {
    return OTPVerifyState(
      token: token ?? this.token,
      otpCode: otpCode ?? this.otpCode,
      verifyAttempts: verifyAttempts ?? this.verifyAttempts,
      failureOption: failureOption ?? this.failureOption,
      status: status ?? this.status,
    );
  }
}
