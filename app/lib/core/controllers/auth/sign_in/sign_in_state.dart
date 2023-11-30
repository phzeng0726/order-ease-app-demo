part of 'sign_in_bloc.dart';

enum SignInStep {
  email,
  password,
}

class SignInState extends Equatable {
  const SignInState({
    required this.email,
    required this.tempUserId, // 在確認email是否在db裡時順便獲取，需要forgot password的時候可以用
    required this.isEmailNotFound, // email不存在，中止sign in，進到sign up page
    required this.isAnonymouslyUser, // 匿名登入
    required this.password,
    required this.isPasswordVisible,
    required this.step,
    required this.failureOption,
    required this.status,
  });

  final String email;
  final String tempUserId;
  final bool isEmailNotFound;
  final bool isAnonymouslyUser;
  final String password;
  final bool isPasswordVisible;
  final SignInStep step;
  final Option<AuthFailure> failureOption;

  final LoadStatus status;

  factory SignInState.initial() => SignInState(
        email: '',
        tempUserId: '',
        isEmailNotFound: false,
        isAnonymouslyUser: false,
        password: '',
        isPasswordVisible: false,
        step: SignInStep.email,
        failureOption: none(),
        status: LoadStatus.initial,
      );

  SignInState copyWith({
    String? email,
    String? tempUserId,
    bool? isEmailNotFound,
    bool? isAnonymouslyUser,
    String? password,
    bool? isPasswordVisible,
    SignInStep? step,
    Option<AuthFailure>? failureOption,
    LoadStatus? status,
  }) {
    return SignInState(
      email: email ?? this.email,
      tempUserId: tempUserId ?? this.tempUserId,
      isEmailNotFound: isEmailNotFound ?? this.isEmailNotFound,
      isAnonymouslyUser: isAnonymouslyUser ?? this.isAnonymouslyUser,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      failureOption: failureOption ?? this.failureOption,
      step: step ?? this.step,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        email,
        tempUserId,
        isEmailNotFound,
        isAnonymouslyUser,
        password,
        isPasswordVisible,
        failureOption,
        step,
        status,
      ];
}
