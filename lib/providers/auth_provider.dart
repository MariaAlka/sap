import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../locator.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = locator<AuthService>();

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String username, String password) async {
    _isAuthenticated = await _authService.login(username, password);
    notifyListeners();
    return _isAuthenticated;
  }

  Future<bool> checkLoginStatus() async {
    _isAuthenticated = await _authService.isLoggedIn();
    notifyListeners();
    return _isAuthenticated;
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getUserData() {
    return _authService.getUserData();
  }
}
