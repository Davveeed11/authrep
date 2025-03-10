import 'package:baka/features/auth/presentation/screens/sign_up_page.dart';
import 'package:flutter/material.dart';

import 'screens/login_page.dart';

class DefaultAuthPage extends StatefulWidget {
  const DefaultAuthPage({super.key});

  @override
  State<DefaultAuthPage> createState() => _DefaultAuthPageState();
}

class _DefaultAuthPageState extends State<DefaultAuthPage> {
  bool defaultPage = true;

  void togglePage() {
    setState(() {
      defaultPage = !defaultPage;

    });
  }

  @override
  Widget build(BuildContext context) {
    if (defaultPage) {
      return LoginPage(onSwitched: togglePage);
    } else {
      return SignUpPage(onSwitched: togglePage);
    }
  }
}
