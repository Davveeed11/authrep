import 'package:baka/features/auth/domain/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> signInWithEmailAndPassword(String email, String password);

  Future<AppUser?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

  Future<void> signOut();
  Future<AppUser?> verifyEmail();
  // Future<AppUser?> resendVerifyEmail();

  Future<AppUser?> resetPassword(String email);

  Future<AppUser?> getCurrentUser();
}
