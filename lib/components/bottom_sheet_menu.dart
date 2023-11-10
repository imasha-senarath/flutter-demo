import 'package:flutter/material.dart';

class MyBottomSheetMenu extends StatelessWidget {
  final Function(String) onItemSelected;

  const MyBottomSheetMenu({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.open_in_browser),
          title: const Text('View'),
          onTap: () {
            onItemSelected('View');
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () {
            onItemSelected('Delete');
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
