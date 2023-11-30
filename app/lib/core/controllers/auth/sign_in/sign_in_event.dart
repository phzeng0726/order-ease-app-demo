part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {
  const SignInEvent();
}

class InitialEvent extends SignInEvent {
  const InitialEvent();
}

class ChangeEmailEvent extends SignInEvent {
  const ChangeEmailEvent(
    this.email,
  );
  final String email;
}

class CheckHasUserEvent extends SignInEvent {
  const CheckHasUserEvent();
}

class ChangePasswordEvent extends SignInEvent {
  const ChangePasswordEvent(
    this.password,
  );
  final String password;
}

class ChangePasswordVisibleEvent extends SignInEvent {
  const ChangePasswordVisibleEvent();
}

class PressSignInWithEmailEvent extends SignInEvent {
  const PressSignInWithEmailEvent();
}

class PressSignInAnonymouslyEvent extends SignInEvent {
  const PressSignInAnonymouslyEvent();
}
