class TextfieldValidaters {
  static String? emailValidator(String email) {
    if (!email.contains("@") || !email.contains(".")) return "invalid email";
    return null;
  }

  static String? passwordValidator(String password) {
    if (password.length > 8)
      return "Invalid password it should contain atleast 8characters";
    return null;
  }

  static String? confirmpasswordValidator(
    String confirmPassword,
    String password,
  ) {
    if (password != confirmPassword) return "Password doesn't match";
    return null;
  }
}
