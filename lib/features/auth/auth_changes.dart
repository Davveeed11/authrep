import 'package:baka/features/auth/presentation/default_auth_page.dart';
import 'package:baka/features/auth/presentation/screens/verify_email.dart';
import 'package:baka/features/home/presentation/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthChanges extends StatefulWidget {
  const AuthChanges({super.key});

  @override
  State<AuthChanges> createState() => _AuthChangesState();
}

class _AuthChangesState extends State<AuthChanges> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return VerifyEmail();
          } else {
            return DefaultAuthPage();
          }
        },
      ),
    );
  }
}
