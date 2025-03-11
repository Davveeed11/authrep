import 'package:baka/features/auth/domain/auth_repo.dart';
import 'package:baka/features/auth/presentation/manager/auth_provider.dart';
import 'package:baka/features/core/presentation/utils/button.dart';
import 'package:baka/features/core/presentation/utils/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/auth_repo_impl.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onSwitched;

  const LoginPage({super.key, this.onSwitched});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthProvider? _provider; // create the provider
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final AuthRepo authRepo = AuthRepoImpl();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ChangeNotifierProvider(
      // top level, wrap the widget with this
      create: (BuildContext context) => AuthProvider(),
      builder: (ctx, child) {
        return Consumer<AuthProvider>(
          //necessary for watching state changes
          builder: (context, provider, child) {
            _provider ??=
                provider; //initialize the provider, it checks if the provider
            // is null and if it is, it assigns the appropriate provider object to it
            final state =
                provider.state; //this is the state located in the AuthProvider
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
                      onChanged: context.read<AuthProvider>().setEmail,
                    ),

                    TextFieldWidget(
                      onChanged: context.read<AuthProvider>().setPassword,
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
                    Consumer<AuthProvider>(
                      builder: (BuildContext context, auth, Widget? child) {
                        return Button(
                          ontap: () {
                            auth.login();
                            print('object');
                          },
                          title: 'Login',
                          loading: auth.state.isLoading,
                          enabled:
                              !auth.state.isLoading &&
                              auth.state.email.isNotEmpty &&
                              auth.state.password.isNotEmpty,
                        );
                      },
                    ),
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
          },
        );
      },
    );
  }
}
