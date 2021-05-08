import 'package:flutter/material.dart';

class Validate {
  // RegEx pattern for validating email addresses.
  static Pattern emailPattern =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
  static RegExp emailRegEx = RegExp(emailPattern);

  // RegEx pattern for validating password.
  static Pattern passwordPattern =
      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$";
  static RegExp passRegEx = RegExp(passwordPattern);

  // Validates an email address.
  static bool isEmail(String value) {
    if (emailRegEx.hasMatch(value.trim())) {
      return true;
    }
    return false;
  }

  // Validates an password.
  static bool isPass(String value) {
    if (passRegEx.hasMatch(value.trim())) {
      return true;
    }
    return false;
  }

  /*
   * Returns an error message if email does not validate.
   */
  static String validateEmail(String value, BuildContext context) {
    String email = value.trim();
    if (email.isEmpty) {
      return "Please enter your email id";
    }
    if (!isEmail(email)) {
      return "please enter valid email id";
    }
    return null;
  }

  /*
   * Returns an error message if required field is empty.
   */
  static String requiredField(String value, String message) {
    if (value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  // static String isanswerrequired(String answer, BuildContext context) {
  //   if (answer.isEmpty) {
  //     return TranslationBase.of(context).answer_cannot_be_empty;
  //   }
  //   return null;
  // }

  static String usernamerequired(String value, BuildContext context) {
    if (value.isEmpty) {
      return "name is required";
    } else  
    return null;
  }

  static String isValidPassword(String password, BuildContext context) {
    String pass = password.trim();
    if (pass.isEmpty) {
      return "password is required";
    }
    if (pass.length < 8) {
      return "minimum 8 length required.";
    }
    return null;
  }

  static String isConfirmPassword(String confirmPassword, String password,
      String title, BuildContext context) {
    String pass = confirmPassword.trim();
    if (pass.isEmpty) {
      return "re-password is required";
    }
    if (pass != password) {
      return "re-password is not match with password";
    }
    return null;
  }

  static String isNotOldPassword(
      String confirmPassword, String oldpassword, BuildContext context) {
    String pass = confirmPassword.trim();
    if (pass.isEmpty) {
      return "password is required";
    }
    if (pass.length < 8) {
      return 'New ' + "password is required";
    }
    if (pass == oldpassword) {
      return "password is required";
    }
    return null;
  }

  // static String isValidUsername(String username, BuildContext context) {
  //   String name = username.trim();
  //   if (name.isEmpty) {
  //     return TranslationBase.of(context).getEmptyNameWarning;
  //   }
  //   if (name.length < 3) {
  //     return TranslationBase.of(context).getValidNameWarning;
  //   }
  //   return null;
  // }
  // static String isValidNoOfDays(String noofDays, BuildContext context) {
  //   String name = noofDays.trim();
  //   if (name.isEmpty) {
  //     return TranslationBase.of(context).no_of_days_warning;
  //   }
  //   else if (int.tryParse(name) > 180 || int.tryParse(name) < 1) {
  //     return TranslationBase.of(context).no_of_days_warning;
  //   }
  //   return null;
  // }

  static bool isValidEmail(String email) {
    final _emailRegExpString = r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
        r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
    return RegExp(_emailRegExpString, caseSensitive: false).hasMatch(email);
  }

  static bool isValidPhoneNumber(String number) {
    final _phoneRegExpString = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    return RegExp(_phoneRegExpString).hasMatch(number);
  }
}