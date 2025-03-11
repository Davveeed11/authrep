import 'package:baka/features/auth/presentation/manager/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/utils/button.dart';
import '../../../core/presentation/utils/text_field_widget.dart';
import '../../data/auth_repo_impl.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onSwitched;

  const SignUpPage({super.key, this.onSwitched});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();

  final AuthRepoImpl authRepo = AuthRepoImpl();

  // void register() async {
  //   if (email.text.isNotEmpty &&
  //       password.text.isNotEmpty &&
  //       name.text.isNotEmpty &&
  //       cpassword.text.isNotEmpty) {
  //     if (password.text == cpassword.text) {
  //       try {
  //         showDialog(
  //           barrierDismissible: false,
  //           context: context,
  //
  //           builder: (context) {
  //             return Center(child: CircularProgressIndicator());
  //           },
  //         );
  //         await authRepo.signUpWithEmailAndPassword(
  //           email.text,
  //           password.text,
  //           name.text,
  //         );
  //         Navigator.pop(context);
  //       } catch (e) {
  //         Navigator.pop(context);
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(SnackBar(content: Text(e.toString())));
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),

      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Sign up Page')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              spacing: 20,
              children: [
                SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'name',
                  isSelected: false,
                  controller: name,
                  onChanged: context.read<AuthProvider>().setName,
                ),
                TextFieldWidget(
                  hintText: 'Email',
                  isSelected: false,
                  controller: email,
                  onChanged: context.read<AuthProvider>().setEmail,
                ),

                TextFieldWidget(
                  hintText: 'password',
                  isSelected: true,
                  controller: password,
                  onChanged: context.read<AuthProvider>().setPassword,
                ),
                TextFieldWidget(
                  hintText: 'Re-type password',
                  isSelected: true,
                  controller: cpassword,
                  onChanged: context.read<AuthProvider>().setCPassword,
                ),
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return Button(
                      ontap: () {
                        auth.signUp();
                        print('object');
                      },
                      title: 'Sign up',
                      loading: auth.state.isLoading,

                      enabled:
                          !auth.state.isLoading &&
                          auth.state.email.isNotEmpty &&
                          auth.state.password.isNotEmpty &&
                          auth.state.name.isNotEmpty &&
                          auth.state.cpassword.isNotEmpty,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    InkWell(
                      onTap: widget.onSwitched,
                      child: Text(
                        'Sign in',
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
  }
}
