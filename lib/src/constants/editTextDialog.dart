import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ratatouille23/src/constants/buttonBackDialog.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/components/dashboard_card.dart';
import 'package:ratatouille23/src/features/dashboard/restaurantInformations.dart';
import 'package:ratatouille23/src/features/employees/buttonPerformance.dart';
import 'package:ratatouille23/src/features/search/search.dart';
import 'package:ratatouille23/src/graphics/listDecoration.dart';

class EditTextDialog extends StatelessWidget {
  EditTextDialog({super.key, required this.hintString});

  String hintString;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shadowColor: Colors.black,
        color: AppTheme.mainWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: AppTheme.lightGray)),
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 4.5,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 0),
              child: TextField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintString,
                  )),
            )));
  }
}
