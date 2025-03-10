import 'package:baka/features/auth/domain/auth_repo.dart';
import 'package:baka/features/core/presentation/utils/button.dart';
import 'package:baka/features/core/presentation/utils/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../data/auth_repo_impl.dart';
import '../forgotPasswordPage/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onSwitched;

  const LoginPage({super.key, this.onSwitched});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final AuthRepo authRepo = AuthRepoImpl();

  void login() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      await authRepo.signInWithEmailAndPassword(email.text, password.text);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          spacing: 20,
          children: [
            SizedBox(height: 10),
            TextFieldWidget(
              hintText: 'Email',
              isSelected: false,
              controller: email,
            ),

            TextFieldWidget(
              hintText: 'password',
              isSelected: true,
              controller: password,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgotPasswordPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Forgot password',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ),
              ],
            ),
            Button(ontap: login, title: 'Sign up'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                InkWell(
                  onTap: widget.onSwitched,
                  child: Text(
                    'Sign up',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
