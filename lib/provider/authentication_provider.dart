import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strawberry_disease_detection/service/auth_service.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  AuthenticationProvider() {
    _authService.userChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }
  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> login(String email, String password) async {
    await _authService.signIn(email, password);
  }

  Future<void> logout() async {
    await _authService.signOut();
  }

  String get userId => _user?.uid ?? '';
}
