import 'package:baka/features/auth/domain/app_user.dart';
import 'package:baka/features/auth/domain/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
        name: '',
        email: userCredential.user!.email!,
        uid: userCredential.user!.uid,
      );
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AppUser?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      AppUser user = AppUser(
        name: name,
        email: userCredential.user!.email!,
        uid: userCredential.user!.uid,
      );
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        return AppUser(uid: user.uid, email: user.email!, name: '');
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AppUser?> verifyEmail() async {
    try {
      await firebaseAuth.currentUser!.sendEmailVerification();
      return null;

    } catch (e) {
      throw Exception(e.toString());
    }
  }


  @override
  Future<AppUser?> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
