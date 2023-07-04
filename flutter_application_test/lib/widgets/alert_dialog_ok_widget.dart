import 'package:flutter/material.dart';

class CustomAlertDialogOK extends StatelessWidget {
  final String title;
  final String message;

  const CustomAlertDialogOK({
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // ปิดหน้าต่างแจ้งเตือน
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
