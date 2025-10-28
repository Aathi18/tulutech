import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final user = await _authService.signIn(email, password);
      _setLoading(false);
      return user != null ? null : 'Login failed. Check credentials.';
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      return e.message;
    } catch (e) {
      _setLoading(false);
      return 'An unknown error occurred.';
    }
  }

  Future<String?> register(String email, String password) async {
    _setLoading(true);
    try {
      final user = await _authService.register(email, password);
      _setLoading(false);
      return user != null ? null : 'Registration failed.';
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      return e.message;
    } catch (e) {
      _setLoading(false);
      return 'An unknown error occurred.';
    }
  }
}