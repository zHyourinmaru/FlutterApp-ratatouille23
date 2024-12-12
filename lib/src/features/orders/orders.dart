import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/components/dashboard_card.dart';
import 'package:ratatouille23/src/features/dashboard/restaurantInformations.dart';
import 'package:ratatouille23/src/features/employees/listViewEmployees.dart';
import 'package:ratatouille23/src/features/search/datePickerRatatouille.dart';
import 'package:ratatouille23/src/features/search/search.dart';
import 'package:ratatouille23/src/graphics/listDecoration.dart';
import 'package:ratatouille23/src/view_models/order_view_model.dart';

import '../../constants/theme.dart';
import 'listViewOrders.dart';


//TODO: inizializzare gli ordini visualizzati a quelli che devono ancora essere completati

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(50, 40, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleOrders(),
          const SizedBox(
            height: 25,
          ),
          const OrderFilter(),
          const SizedBox(height: 8),
          const OrderBarOrders(),
          Expanded(
              child: Row(children: [
            Expanded(child: ListViewOrders(
                future: Provider.of<OrderViewModel>(context, listen: false).getOrders())
            ),
            SizedBox(width: 40),
          ])),
        ],
      ),
    );
  }
}

class OrderFilter extends StatefulWidget {
  const OrderFilter({super.key});

  @override
  State<OrderFilter> createState() => _OrderFilterState();
}

bool isChecked = false;
List<bool> _selected = [true, false, false];

class _OrderFilterState extends State<OrderFilter> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppTheme.mainGreen;
    }
    return AppTheme.mainYellow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(children: [
                  ButtonBar(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _selected[0] = true;
                            _selected[2] = false;
                            _selected[1] = false;
                            isChecked = false;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _selected[0] == true && isChecked == false
                                    ? AppTheme.mainYellow
                                    : AppTheme.mainWhite,
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            "today".tr,
                            style: _selected[0] == true && isChecked == false
                                ? Theme.of(context).textTheme.labelMedium
                                : Theme.of(context).textTheme.displaySmall,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            _selected[1] = true;
                            _selected[2] = false;
                            _selected[0] = false;
                            isChecked = false;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selected[1] == true
                                ? AppTheme.mainYellow
                                : AppTheme.mainWhite,
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            "thisWeek".tr,
                            style: _selected[1] == true
                                ? Theme.of(context).textTheme.labelMedium
                                : Theme.of(context).textTheme.displaySmall,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            _selected[2] = true;
                            _selected[0] = false;
                            _selected[1] = false;
                            isChecked = false;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selected[2] == true
                                ? AppTheme.mainYellow
                                : AppTheme.mainWhite,
                            textStyle: Theme.of(context).textTheme.labelMedium,
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            "thisMonth".tr,
                            style: _selected[2] == true
                                ? Theme.of(context).textTheme.labelMedium
                                : Theme.of(context).textTheme.displaySmall,
                          )),
                    ],
                  ),
                  const SizedBox(width: 5),
                  Text("or".tr, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: 5),
                  Container(
                    child: Row(children: [
                      Checkbox(
                          checkColor: AppTheme.mainWhite,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                    ]),
                  ),
                  const DatePickerRatatouille(),
                  const SizedBox(width: 10),
                  const DecoratorVertical(),
                  const SizedBox(width: 10),
                  const SearchBar(),
                  const SizedBox(width: 40),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleOrders extends StatelessWidget {
  const TitleOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "titleOrders".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class OrderBarOrders extends StatefulWidget {
  const OrderBarOrders({super.key});

  @override
  State<OrderBarOrders> createState() => _OrderBarOrdersState();
}

class _OrderBarOrdersState extends State<OrderBarOrders> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.mainGreen,
      elevation: 2,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.18,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(children: [
            Container(
                width: 100,
                child: Text(
                  'id'.tr,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            const SizedBox(width: 10),
            Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Text(
                  'date'.tr,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            const SizedBox(width: 10),
            Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Text(
                  'roomAttendants'.tr,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            const SizedBox(width: 10),
            Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Text(
                  'kitchenAttendants'.tr,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            const SizedBox(width: 10),
            Container(
                width: MediaQuery.of(context).size.width / 8,
                child: Text(
                  'status'.tr,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            const SizedBox(width: 10),
            Container(
                width: 100,
                child: Text(
                  'amount'.tr,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            const SizedBox(width: 15),
          ]),
        ),
      ),
    );
  }
}
