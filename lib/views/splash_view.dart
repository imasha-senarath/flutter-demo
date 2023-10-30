import 'package:flutter/material.dart';
import 'package:flutter_demo/views/home_view.dart';
import 'package:flutter_demo/views/login_view.dart';
import '../const.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        ),
      );
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Icon(
            Icons.album_rounded,
            color: primaryColor,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
