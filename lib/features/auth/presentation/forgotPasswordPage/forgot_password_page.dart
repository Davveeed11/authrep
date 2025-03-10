import 'package:baka/features/core/presentation/utils/button.dart';
import 'package:baka/features/core/presentation/utils/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../../data/auth_repo_impl.dart';
import '../../domain/auth_repo.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController email = TextEditingController();

  void fwPassword() async {
    final AuthRepo authRepo = AuthRepoImpl();
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    try {
      await authRepo.resetPassword(email.text);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Reset successful')));
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);

      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(height: 15),

            TextFieldWidget(
              hintText: 'Email',
              isSelected: false,
              controller: email,
            ),
            SizedBox(height: 15),
            Button(ontap: fwPassword, title: 'Reset'),
          ],
        ),
      ),
    );
  }
}
