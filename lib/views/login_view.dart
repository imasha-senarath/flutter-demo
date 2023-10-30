import 'package:flutter/material.dart';
import 'package:flutter_demo/components/button.dart';
import 'package:flutter_demo/components/dialog.dart';
import 'package:flutter_demo/const.dart';
import 'package:flutter_demo/views/home_view.dart';

import '../components/text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void userLogin() {
    String emailValue = emailController.text;
    String passwordValue = passwordController.text;

    if (emailValue == "me@imasha.com" && passwordValue == "1234") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const HomeView(),
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const MyDialog(
              title: 'Error',
              description: 'Invalid credentials',
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Icon(
              Icons.album_rounded,
              color: primaryColor,
              size: 100.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Flutter Demo",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur elit nam et venenatis.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            MyTextField(
              hintText: 'Email',
              controller: emailController,
              obscureText: false,
              icon: const Icon(Icons.email),
            ),
            const SizedBox(
              height: 10.0,
            ),
            MyTextField(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
              icon: const Icon(Icons.password),
            ),
            const SizedBox(
              height: 15.0,
            ),
            MyButton(
              onTap: userLogin,
              name: 'Login',
            )
          ],
        ),
      ),
    );
  }
}
