import 'package:baka/features/auth/presentation/default_auth_page.dart';
import 'package:baka/features/home/presentation/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthChanges extends StatefulWidget {
  const AuthChanges({super.key});

  @override
  State<AuthChanges> createState() => _AuthChangesState();
}

class _AuthChangesState extends State<AuthChanges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return DefaultAuthPage();
          }
        },
      ),
    );
  }
}
