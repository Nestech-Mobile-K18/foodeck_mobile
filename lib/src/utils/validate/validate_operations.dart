import 'package:template/src/pages/export.dart';

@immutable
class ValidateOperations {
  const ValidateOperations._();

  static normalValidation(
    dynamic value,
  ) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }

  static emailValidation(dynamic email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (email == null || email.isEmpty || !emailValid) {
      return AppStrings.makeSureCorrectMail;
    }
    return null;
  }

  static passwordValidation(dynamic password) {
    if (password == null || password.isEmpty) {
      return AppStrings.requiredField;
    } else if (password.length < 8) {
      return AppStrings.passwordToShort;
    }
    return null;
  }

  static phoneValidation(dynamic phone) {
    bool phoneValid =
        RegExp(r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/').hasMatch(phone);

    if (phone == null || phone.isEmpty) {
      return AppStrings.requiredField;
    } else if (!phoneValid) {
      return AppStrings.makeSureCorrectPass;
    }
    return null;
  }
}
