import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/customTextFormField.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/features/menu/listViewDishes.dart';
import 'package:ratatouille23/src/features/sideNavigationBar/sideNavigationBar.dart';
import 'package:ratatouille23/src/graphics/bottomDecoration.dart';

import 'package:ratatouille23/src/graphics/topDecoration.dart';
import 'package:ratatouille23/src/models/table_model.dart';
import 'package:ratatouille23/src/view_models/user_view_model.dart';
import '../../constants/valueListenableBuilder3.dart';

class selectTable extends StatelessWidget {
  selectTable({super.key});
  TableModel? table;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 3.5,
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
            child: Column(
          children: [
            Row(
              children: [
                Text(
                  'tableSelect'.tr,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                DropdownButton<TableModel>(
                  value: table,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: Theme.of(context).textTheme.bodyLarge,
                  underline: Container(
                    height: 2,
                    color: AppTheme.mainGreen,
                  ),
                  onChanged: (TableModel? value) {},
                  items: [],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 50),
                Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width / 8, 50),
                          backgroundColor: AppTheme.mainYellow,
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text("select".tr))),
              ],
            ),
          ],
        )));
  }
}
