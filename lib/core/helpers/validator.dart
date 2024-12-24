class Validator {
  // Валидация email
  static String? validateUserEmail(String? email) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]{1,10}@(?:(?!.*--)[a-zA-Z0-9-]{1,10}(?<!-))(?:\.(?:[a-zA-Z0-9-]{2,10}))+$",
    );

    if (email == null || email.isEmpty) {
      return 'Email is required.';
    }

    if (email.length < 6 || email.length > 30) {
      return 'Email should be between 6 and 30 characters.';
    }

    if (!emailRegExp.hasMatch(email)) {
      return 'Email is incorrect.';
    }

    return null;
  }

  // Валидация password
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required.';
    }

    if (password.length < 6 || password.length > 10) {
      return 'Password should be between 6 and 10 characters.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter.';
    }

    if (!RegExp(r'\d').hasMatch(password)) {
      return 'Password must contain at least one digit.';
    }

    return null;
  }
}
