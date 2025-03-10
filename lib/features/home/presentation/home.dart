import 'package:baka/features/auth/data/auth_repo_impl.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthRepoImpl authRepo = AuthRepoImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              authRepo.signOut();
            },
            icon: Icon(Icons.logout,color: Colors.red,),
          ),
        ],
      ),
    );
  }
}
