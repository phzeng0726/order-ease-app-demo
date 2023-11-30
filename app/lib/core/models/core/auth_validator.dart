// https://stackoverflow.com/questions/56253787/how-to-handle-textfield-validation-in-password-in-flutter
import 'package:flutter/cupertino.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';

extension AuthValidator on String {
  String? isValidEmail(BuildContext context) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (isEmpty) {
      return AppLocalizations.of(context)!.emptyEmail;
    } else {
      if (!regex.hasMatch(this)) {
        return AppLocalizations.of(context)!.invalidEmail;
      } else {
        return null;
      }
    }
  }

  String? isValidPassword(
    BuildContext context,
    String confirmPasswordValue,
  ) {
    /*
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    (?=.*[A-Z])       // should contain at least one upper case
    (?=.*[a-z])       // should contain at least one lower case
    (?=.*?[0-9])      // should contain at least one digit
    (?=.*?[!@#\$&*~]) // should contain at least one Special character
    .{6,}             // Must be at least 6 characters in length  
   */
    RegExp regex = RegExp(r'^.{6,}$');

    if (!regex.hasMatch(this)) {
      return AppLocalizations.of(context)!.invalidPassword;
    } else if (this != confirmPasswordValue) {
      return AppLocalizations.of(context)!.passwordNotMatch;
    } else {
      return null;
    }
  }

  String? isValidConfirmPassword(BuildContext context, String passwordValue) {
    /*
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    (?=.*[A-Z])       // should contain at least one upper case
    (?=.*[a-z])       // should contain at least one lower case
    (?=.*?[0-9])      // should contain at least one digit
    (?=.*?[!@#\$&*~]) // should contain at least one Special character
    .{6,}             // Must be at least 6 characters in length  
   */
    RegExp regex = RegExp(r'^.{6,}$');

    if (!regex.hasMatch(this)) {
      return AppLocalizations.of(context)!.invalidPassword;
    } else if (passwordValue != this) {
      return AppLocalizations.of(context)!.passwordNotMatch;
    } else {
      return null;
    }
  }

  String? isValidSignInPassword(BuildContext context) {
    /*
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    (?=.*[A-Z])       // should contain at least one upper case
    (?=.*[a-z])       // should contain at least one lower case
    (?=.*?[0-9])      // should contain at least one digit
    (?=.*?[!@#\$&*~]) // should contain at least one Special character
    .{6,}             // Must be at least 6 characters in length  
   */
    RegExp regex = RegExp(r'^.{6,}$');

    if (!regex.hasMatch(this)) {
      return AppLocalizations.of(context)!.invalidPassword;
    } else {
      return null;
    }
  }

  String? isValidFirstName(BuildContext context) {
    if (isEmpty) {
      return AppLocalizations.of(context)!.firstNameHintText;
    } else {
      return null;
    }
  }

  String? isValidLastName(BuildContext context) {
    if (isEmpty) {
      return AppLocalizations.of(context)!.lastNameHintText;
    } else {
      return null;
    }
  }
}
