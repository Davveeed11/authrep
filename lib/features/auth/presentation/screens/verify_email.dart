import 'dart:async';

import 'package:baka/features/auth/data/auth_repo_impl.dart';
import 'package:baka/features/core/presentation/utils/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/screen/home.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final AuthRepoImpl authRepoImpl = AuthRepoImpl();
  bool isVerified = false;
  TextEditingController email = TextEditingController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isVerified) {
      authRepoImpl.verifyEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) async {
        await FirebaseAuth.instance.currentUser!.reload();
        setState(() {
          isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        });
        if (isVerified) {
          timer?.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      isVerified
          ? const Home()
          : Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      Icon(Icons.email, size: 65),
                      SizedBox(height: 25),
                      Text(
                        'A verification email has been sent  ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'to your mail ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 25),

                      Button(
                        title: 'resend',loading: false,enabled: false,
                        ontap: () {
                          authRepoImpl.verifyEmail();
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('email sent')));
                        },
                      ),
                      SizedBox(height: 15),

                      TextButton(
                        onPressed: () {
                          authRepoImpl.signOut();
                        },
                        child: Text('cancel'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
}
