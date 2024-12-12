import 'package:flutter/material.dart';

class AppErrorDialog extends StatelessWidget {
  final String errorMessage;
  const AppErrorDialog({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          Text(errorMessage),
          const Text("esci"),
        ],
      ),
    );
  }
}
