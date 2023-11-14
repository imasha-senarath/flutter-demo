import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/views/main_view.dart';
import 'package:flutter_demo/views/login_view.dart';
import 'package:flutter_demo/views/register_view.dart';

class MyAuth extends StatelessWidget {
  const MyAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      )
    );
  }
}
