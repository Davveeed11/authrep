import 'package:baka/features/auth/data/auth_repo_impl.dart';
import 'package:baka/features/auth/domain/auth_repo.dart';
import 'package:baka/features/auth/presentation/manager/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import for Material widgets

class AuthProvider extends ChangeNotifier {
  final AuthState state = AuthState();
  final AuthRepoImpl authRepoImpl = AuthRepoImpl(); // Instantiate directly

  String? _errorMessage; // To store error messages

  String? get errorMessage => _errorMessage; // Getter for error message

  setEmail(String email) {
    state.email = email;
    notifyListeners();
  }

  setPassword(String password) {
    state.password = password;
    notifyListeners();
  }

  Future<void> login() async {
    state.isLoading = true;
    _errorMessage = null; // Clear previous error
    notifyListeners();

    try {
      print('pre-login');
      await authRepoImpl.signInWithEmailAndPassword(state.email, state.password);
      print('post-login');

      // If signInWithEmailAndPassword succeeds, you might want to fetch
      // additional user data or perform other actions here.

      state.isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle Firebase Auth exceptions specifically
      print('Login error: $e');
      state.isLoading = false;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            _errorMessage = 'No user found for that email.';
            break;
          case 'wrong-password':
            _errorMessage = 'Wrong password provided for that user.';
            break;
          case 'invalid-email':
            _errorMessage = 'The email address is badly formatted.';
            break;
        // Add more cases for other FirebaseAuthException codes
          default:
            _errorMessage = 'An error occurred during login: ${e.message}';
        }
      } else {
        _errorMessage = 'An unexpected error occurred: $e';
      }
      notifyListeners();
    }
  }
}