import 'package:baka/features/auth/data/auth_repo_impl.dart';
import 'package:baka/features/auth/presentation/manager/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  setCPassword(String confirmPassword) {
    state.cPassword = confirmPassword;
    notifyListeners();
  }

  setName(String name) {
    state.name = name;
    notifyListeners();
  }

  Future<void> login() async {
    state.isLoading = true;
    _errorMessage = null; // Clear previous error
    notifyListeners();

    try {
      print('pre-login');
      await authRepoImpl.signInWithEmailAndPassword(
        state.email,
        state.password,
      );
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

  Future<void> signUp() async {
    state.isLoading = true;
    _errorMessage = null; // Clear previous error
    notifyListeners();

    try {
      print('pre-login');
      await authRepoImpl.signUpWithEmailAndPassword(
        state.email,
        state.password,
        state.name,
      );
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

  Future<void> signOut() async {
    state.isLoading = true;
    _errorMessage = null; //// Clear previous error
    await authRepoImpl.signOut();
    notifyListeners();
  }

  Future<void> resetPassword(BuildContext context) async {
    state.isLoading = true;
    notifyListeners();
    _errorMessage = null; // Clear previous error
    try {
      await authRepoImpl.resetPassword(state.email);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: MediaQuery.sizeOf(context).height / 4,
              width: MediaQuery.sizeOf(context).width / 1.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 40, color: Colors.green),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Successful check your email',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(_errorMessage = e.message.toString()),
          );
        },
      );
    }

    state.isLoading = false;
    notifyListeners();
  }
}
