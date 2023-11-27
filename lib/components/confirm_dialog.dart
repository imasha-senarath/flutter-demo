import 'package:flutter/material.dart';

class MyConfirmDialog extends StatelessWidget {
  final Future<void>? onTap;
  final String title;
  final String description;

  const MyConfirmDialog({
    super.key,
    required this.title,
    required this.description, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            await onTap;
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.blue,
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(10.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          child: const Text(
            'Yes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
