import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/app_bar.dart';
import 'package:flutter_demo/components/button.dart';
import 'package:flutter_demo/components/dialog.dart';
import 'package:flutter_demo/const.dart';
import 'package:flutter_demo/views/home_view.dart';
import 'package:flutter_demo/views/main_view.dart';

import '../components/text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void userRegister() async {
    String emailValue = emailController.text;
    String passwordValue = passwordController.text;
    String nameValue = nameController.text;

    if (nameValue.isEmpty || emailValue.isEmpty || passwordValue.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const MyDialog(
              title: 'Error',
              description: "Field can't be empty",
            );
          });
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailValue,
          password: passwordValue,
        );

        CollectionReference usersCollectionReference =
            FirebaseFirestore.instance.collection('Users');

        Map<String, dynamic> userData = {
          'email': userCredential.user?.email,
          'name': nameValue,
        };

        usersCollectionReference.doc(userCredential.user?.uid).set(userData);

        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const MainView(),
          ),
        );
      } on FirebaseException catch (e) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialog(
                title: 'Error',
                description: e.code,
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                hintText: 'Name',
                controller: nameController,
                obscureText: false,
                icon: const Icon(Icons.person),
                multiLine: 1,
              ),
              const SizedBox(
                height: 10.0,
              ),
              MyTextField(
                hintText: 'Email',
                controller: emailController,
                obscureText: false,
                icon: const Icon(Icons.email),
                multiLine: 1,
              ),
              const SizedBox(
                height: 10.0,
              ),
              MyTextField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
                icon: const Icon(Icons.password),
                multiLine: 1,
              ),
              const SizedBox(
                height: 15.0,
              ),
              MyButton(
                onTap: userRegister,
                name: 'Register',
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  const Text(
                    "Already registered?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Login.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
