import 'package:flutter/material.dart';
import 'package:flutter_demo/components/hamburger.dart';

import '../const.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title:  const Text('Home'),
      ),
      drawer: const MyHamburger(),
    );
  }
}


