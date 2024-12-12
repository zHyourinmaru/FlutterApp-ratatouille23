import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/customTextFormField.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/constants/valueListeanableBuilder2.dart';
import 'package:ratatouille23/src/features/menu/listViewDishes.dart';
import 'package:ratatouille23/src/features/sideNavigationBar/sideNavigationBar.dart';
import 'package:ratatouille23/src/graphics/bottomDecoration.dart';

import 'package:ratatouille23/src/graphics/topDecoration.dart';
import '../../constants/valueListenableBuilder3.dart';

class OrderLog extends StatefulWidget {
  const OrderLog({super.key, required tableNumber});

  static ValueNotifier<List<String>> dishSelection = ValueNotifier([""]);

  @override
  State<OrderLog> createState() => _OrderLogState();
}

class _OrderLogState extends State<OrderLog> {
  var tableNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 3.5,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'table'.tr,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                tableNumber,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Expanded(child: SizedBox()),
              Tooltip(
                  message: "tutorialOrder".tr,
                  child: IconButton(
                      color: AppTheme.mainYellow,
                      onPressed: () {},
                      iconSize: 40,
                      icon: Icon(FeatherIcons.helpCircle))),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.2,
            width: MediaQuery.of(context).size.width / 3.5,
            decoration: BoxDecoration(
              color: AppTheme.mainWhite,
              border: Border.all(color: AppTheme.lightGray),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: OrderLog.dishSelection,
                          builder: (BuildContext context, List<String> dishes,
                              Widget? child) {
                            return ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: dishes.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index != dishes.length) {
                                    return Container(
                                        key: Key('$index'),
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 7.5, 0, 7.5),
                                        height: 90,
                                        color: AppTheme.mainWhite,
                                        child: Card(
                                            child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          child: Dismissible(
                                            key: UniqueKey(),
                                            direction:
                                                DismissDirection.endToStart,
                                            background: Container(
                                                color: AppTheme.mainRed,
                                                child: Row(children: const [
                                                  SizedBox(width: 15),
                                                  Icon(
                                                    FeatherIcons.trash2,
                                                    size: 50,
                                                    color: AppTheme.mainWhite,
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                ])),
                                            onDismissed:
                                                (DismissDirection direction) {
                                              dishes.removeAt(index);
                                              setState(() {});
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  dishes[index][0],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                )),
                                          ),
                                        )));
                                  }
                                });
                          }),
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          ButtonCancel(),
                          ButtonSend(),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonCancel extends StatelessWidget {
  ButtonCancel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width / 8, 50),
              backgroundColor: AppTheme.mainRed,
              textStyle: Theme.of(context).textTheme.labelLarge,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text("cancel".tr)));
  }
}

class ButtonSend extends StatelessWidget {
  ButtonSend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width / 8, 50),
              backgroundColor: AppTheme.mainYellow,
              textStyle: Theme.of(context).textTheme.labelLarge,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text("send".tr)));
  }
}
