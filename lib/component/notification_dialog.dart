import 'package:flutter/material.dart';

void notificationDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
