import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/auth/otp_verify/otp_verify_bloc.dart';
import 'package:ordering_system_client_app/core/repos/auth_repository.dart';
import 'package:ordering_system_client_app/views/auth/widgets/auth_button.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/core/utils/app_screen_util.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_dialog.dart';
import 'package:ordering_system_client_app/views/core/widgets/loading_overlay.dart';

class OTPVerifyWidget extends StatelessWidget {
  const OTPVerifyWidget({
    super.key,
    required this.email,
    required this.succeedRouteToName,
  });

  final String email;
  final String succeedRouteToName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OTPVerifyBloc(
        context.read<AuthRepository>(),
      )..add(
          SendOTPEvent(
            email: email,
          ),
        ),
      child: BlocListener<OTPVerifyBloc, OTPVerifyState>(
        listenWhen: (p, c) => p.status != c.status,
        listener: (context, state) {
          AppScreenUtil.mapLoadStatus(
            state.status,
            initial: () {},
            inProgress: () => LoadingOverlay.show(context),
            succeed: () {
              LoadingOverlay.hide();

              context.replaceNamed(succeedRouteToName);
            },
            failed: () {
              if (state.verifyAttempts >= 3) {
                // 驗證次數過多，返回上一頁
                showErrorDialog(
                  context,
                  contentOption: state.failureOption,
                  onPressed: () => context
                    ..pop() // 退出dialog
                    ..pop(), // 退回上一頁
                );
              } else {
                showErrorDialog(
                  context,
                  contentOption: state.failureOption,
                );
              }
            },
          );
        },
        child: BlocBuilder<OTPVerifyBloc, OTPVerifyState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 6 碼 OTP
                FittedBox(
                  child: VerificationCode(
                    length: 6,
                    itemSize: 56,
                    underlineUnfocusedColor: const Color.fromARGB(
                      255,
                      212,
                      212,
                      212,
                    ),
                    underlineWidth: 2,
                    textStyle: AppTextStyle.heading2(),
                    clearAll: Padding(
                      padding: const EdgeInsets.all(
                        AppPaddingSize.mediumAll,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.clearVerificationCode,
                        style: AppTextStyle.text(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    onCompleted: (value) {
                      context.read<OTPVerifyBloc>().add(
                            ChangeOTPEvent(
                              otpCode: value,
                            ),
                          );
                      context.read<OTPVerifyBloc>().add(
                            const VerifyOTPEvent(),
                          );
                    },
                    onEditing: (value) {
                      final bool onEditing = value;
                      if (!onEditing) FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // 剩餘次數
                Text(
                  '${AppLocalizations.of(context)!.verifyAttempts}: ${3 - state.verifyAttempts}',
                  style: AppTextStyle.text(),
                ),
                const SizedBox(
                  height: 100,
                ),
                // 驗證
                AuthButton(
                  title: AppLocalizations.of(context)!.confirmButton,
                  onPressed: () => context.read<OTPVerifyBloc>().add(
                        const VerifyOTPEvent(),
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
