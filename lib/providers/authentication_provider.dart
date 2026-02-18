import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/models/authentication_model.dart';
import 'package:frontend_hackathon_mobile/models/user_model.dart';
import 'package:frontend_hackathon_mobile/services/authentication_service.dart';
import 'package:frontend_hackathon_mobile/services/exceptions/authentication_exception.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();

  UserModel? _user;
  UserModel? get user => _user;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> handleSignupUser(SignupRequest request) async {
    try {
      _setLoading(true);
      _clearError();

      UserModel user = await _authService.signupUser(request);
      _setLoggedIn(user: user, loggedIn: true);

      return _isLoggedIn;
    } on SignUpException catch (e) {
      _setError(e.message);
      _setLoggedIn(user: null, loggedIn: false);

      return _isLoggedIn;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> handleLoginUser(LoginRequest request) async {
    try {
      _setLoading(true);
      _clearError();

      UserModel user = await _authService.loginUser(request);
      _setLoggedIn(user: user, loggedIn: true);

      return _isLoggedIn;
    } on LoginException catch (e) {
      _setError(e.message);
      _setLoggedIn(user: null, loggedIn: false);

      return _isLoggedIn;
    } finally {
      _setLoading(false);
    }
  }

  void handleLogoutUser() {
    _setLoading(true);
    _clearError();

    _authService.logout();
    _setLoggedIn(user: null, loggedIn: false);
    _setLoading(false);
  }

  void _setLoggedIn({UserModel? user, required bool loggedIn}) {
    _user = user;
    _isLoggedIn = loggedIn;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
