import 'package:flutter/material.dart';

class CustomAlertDialogYesNo extends StatelessWidget {
  final String title;
  final String message;

  const CustomAlertDialogYesNo({
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
            Navigator.of(context).pop(true); // ปิดหน้าต่างแจ้งเตือนและส่งค่า true
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // ปิดหน้าต่างแจ้งเตือนและส่งค่า false
          },
          child: Text('No'),
        ),
      ],
    );
  }
}
