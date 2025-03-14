import 'package:baka/features/auth/presentation/manager/auth_provider.dart';
import 'package:baka/features/core/presentation/utils/button.dart';
import 'package:baka/features/core/presentation/utils/round_button_widget.dart';
import 'package:baka/features/core/presentation/utils/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            // appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),

                  Row(
                    spacing: 20,
                    children: [
                      RoundbuttonWidget(
                        icons: Icons.arrow_back,
                        ontap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  Text(
                    'To reset password fill in your email',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  TextFieldWidget(
                    hintText: 'Email',
                    isSelected: false,
                    controller: email,
                    onChanged: context.read<AuthProvider>().setEmail,
                  ),
                  SizedBox(height: 10),
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return Button(
                        ontap: () {
                          authProvider.resetPassword(context);
                          email.clear();
                        },
                        title: 'Reset',
                        loading: authProvider.state.isLoading,
                        enabled:
                            authProvider.state.email.isNotEmpty &&
                            !authProvider.state.isLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
