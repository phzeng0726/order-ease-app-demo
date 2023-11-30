import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/core/failure.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/core/widgets/loading_overlay.dart';

// 一個按鈕
void showSuccessDialog(
  BuildContext context, {
  String? title,
  String? content,
  String? buttonTitle,
  void Function()? onPressed,
}) {
  return WidgetsBinding.instance.addPostFrameCallback((_) {
    LoadingOverlay.hide();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: Text(content ?? ''),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed ?? () => context.pop(),
              child: Text(buttonTitle ?? 'OK'),
            ),
          ],
        );
      },
    );
  });
}

// 兩個按鈕
void showActionDialog(
  BuildContext context, {
  String? title,
  String? content,
  String? leftTitle,
  String? rightTitle,
  void Function()? leftOnPressed,
  void Function()? rightOnPressed,
}) {
  return WidgetsBinding.instance.addPostFrameCallback((_) {
    LoadingOverlay.hide();

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ''),
          content: Text(content ?? ''),
          actions: <Widget>[
            TextButton(
              onPressed: leftOnPressed ?? () => context.pop(),
              child: Text(leftTitle ?? 'Back'),
            ),
            TextButton(
              onPressed: rightOnPressed ?? () => context.pop(),
              child: Text(rightTitle ?? 'OK'),
            ),
          ],
        );
      },
    );
  });
}

// 提供給錯誤訊息使用
Future<String> authFailureConverter(BuildContext context, AuthFailure f) async {
  AppLocalizations appLocal = AppLocalizations.of(context)!;

  if (f == AuthFailure.operationNotAllowed()) {
    return appLocal.operationNotAllowed;
  } else if (f == AuthFailure.invalidEmail()) {
    return appLocal.invalidEmail;
  } else if (f == AuthFailure.wrongPassword()) {
    return appLocal.wrongPassword;
  } else if (f == AuthFailure.emailNotFoundInDatabase()) {
    return appLocal.emailNotFoundInDatabase;
  } else if (f == AuthFailure.uidNotFoundInDatabase()) {
    return appLocal.uidNotFoundInDatabase;
  } else if (f == AuthFailure.serverError()) {
    return appLocal.serverError;
  } else if (f == AuthFailure.unexpected()) {
    return appLocal.unexpected;
  } else {
    return 'System: ${f.message!}';
  }
}

Future<String> failureConverter(BuildContext context, Failure f) async {
  AppLocalizations appLocal = AppLocalizations.of(context)!;

  if (f == Failure.serverError()) {
    return appLocal.serverError;
  } else if (f == Failure.unexpected()) {
    return appLocal.unexpected;
  } else {
    return 'System: ${f.message!}';
  }
}

void showErrorDialog(
  BuildContext context, {
  String? title,
  required Option<dynamic> contentOption,
  void Function()? onPressed,
}) async {
  late String errorMessage = '';
  final _failure = contentOption.getOrElse(() => AuthFailure.empty());

  if (_failure is AuthFailure) {
    errorMessage = await authFailureConverter(context, _failure);
  } else if (_failure is Failure) {
    errorMessage = await failureConverter(context, _failure);
  }

  return WidgetsBinding.instance.addPostFrameCallback((_) {
    LoadingOverlay.hide();

    showSuccessDialog(
      context,
      title: title ?? AppLocalizations.of(context)!.oops,
      content: errorMessage,
      buttonTitle: AppLocalizations.of(context)!.oopsReturn,
      onPressed: onPressed ?? () => context.pop(),
    );
  });
}
