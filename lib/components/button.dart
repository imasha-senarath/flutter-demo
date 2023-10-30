import 'package:flutter/material.dart';

import '../const.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String name;

  const MyButton({super.key, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Text(name),
      ),
    );
  }
}
