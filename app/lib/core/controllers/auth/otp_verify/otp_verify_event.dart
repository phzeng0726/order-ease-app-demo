part of 'otp_verify_bloc.dart';

@immutable
sealed class OTPVerifyEvent {
  const OTPVerifyEvent();
}

class SendOTPEvent extends OTPVerifyEvent {
  const SendOTPEvent({
    required this.email,
  });
  final String email;
}

class ChangeOTPEvent extends OTPVerifyEvent {
  const ChangeOTPEvent({
    required this.otpCode,
  });
  final String otpCode;
}

class VerifyOTPEvent extends OTPVerifyEvent {
  const VerifyOTPEvent();
}
