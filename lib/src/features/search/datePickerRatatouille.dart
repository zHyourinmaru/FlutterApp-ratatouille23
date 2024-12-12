import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/components/dashboard_card.dart';
import 'package:ratatouille23/src/features/dashboard/restaurantInformations.dart';
import 'package:ratatouille23/src/features/employees/listViewEmployees.dart';
import 'package:ratatouille23/src/features/search/search.dart';
import 'package:ratatouille23/src/graphics/listDecoration.dart';
import 'package:intl/intl.dart';

class DatePickerRatatouille extends StatefulWidget {
  const DatePickerRatatouille({super.key, this.onPicked});

  final  void Function(String)? onPicked;

  @override
  State<DatePickerRatatouille> createState() => _DatePickerRatatouilleState();
}

class _DatePickerRatatouilleState extends State<DatePickerRatatouille> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 140,
      child: Center(
        child: TextField(
          controller: dateController,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
              icon: Icon(FeatherIcons.calendar, color: AppTheme.mainGreen),
              labelText: "date".tr,
              labelStyle: Theme.of(context).textTheme.bodyMedium),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat("yyyy-mm-dd").format(pickedDate);
              setState(() {
                dateController.text = formattedDate.toString();
              });
              widget.onPicked!(formattedDate);
            } else {
              print("Not Selected.");
            }
          },
        ),
      ),
    );
  }
}
