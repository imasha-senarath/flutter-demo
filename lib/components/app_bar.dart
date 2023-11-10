import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final bool isBackButtonEnabled;

  const MyAppBar({super.key, required this.title, required this.isBackButtonEnabled});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: isBackButtonEnabled ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ) : null,
    );
  }
}
