class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class SignUpException extends AuthException {
  SignUpException(super.message);
}

class LoginException extends AuthException {
  LoginException(super.message);
}
