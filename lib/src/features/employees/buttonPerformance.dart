import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ratatouille23/src/constants/theme.dart';

import 'employeeDialog.dart';

class ButtonPerfomanceEmployee extends StatelessWidget {
  const ButtonPerfomanceEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.mainYellow,
          textStyle: Theme.of(context).textTheme.labelLarge,
          padding: EdgeInsets.fromLTRB(40, 5, 40, 7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text("viewPerformance".tr));
  }
}
