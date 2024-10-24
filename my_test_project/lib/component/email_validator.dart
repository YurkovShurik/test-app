class EmailValidator {
  static bool validate(String email) {
    String emailPattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    return RegExp(emailPattern).hasMatch(email);
  }
}