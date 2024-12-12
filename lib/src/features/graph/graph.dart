import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/features/employees/employees.dart';
import 'package:ratatouille23/src/features/search/datePickerRatatouille.dart';
import 'package:ratatouille23/src/graphics/listDecoration.dart';
import 'package:ratatouille23/src/models/order_model.dart';
import 'package:ratatouille23/src/models/role.dart';
import 'package:ratatouille23/src/models/user_model.dart';
import 'package:ratatouille23/src/view_models/order_view_model.dart';
import 'package:ratatouille23/src/view_models/user_view_model.dart';

import '../../constants/theme.dart';

class Graphs extends StatelessWidget {
  const Graphs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.mainWhite,
        padding: const EdgeInsets.fromLTRB(50, 40, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TitleGraphs(),
              SizedBox(height: 25),
              GraphsBody(),
            ],
          ),
        ));
  }
}

class TitleGraphs extends StatelessWidget {
  const TitleGraphs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "titleGraphs".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class GraphsBody extends StatefulWidget {
  const GraphsBody({super.key});

  @override
  State<GraphsBody> createState() => _GraphsBodyState();
}

class _GraphsBodyState extends State<GraphsBody> {
  //Employees employee = Employees.;

  Role selectedRole = Role.WAITER;
  DateTime? fromDate;
  DateTime? toDate;

  // Lasso personalizzabile quanti ordini ha registrato e valore comulatori

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'dateSelect'.tr,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                DatePickerRatatouille(
                  onPicked: (dateString) {
                    fromDate = DateTime.parse(dateString);
                  },
                ),
                Text(
                  'to'.tr,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 10),
                DatePickerRatatouille(
                  onPicked: (dateString) {
                    toDate = DateTime.parse(dateString);
                  },
                ),
                const SizedBox(width: 10),
              ]),
              const SizedBox(height: 30),
              FutureBuilder(
                  future: Provider.of<UserViewModel>(context, listen: false)
                      .getUsers((errorMessage) {
                    print(errorMessage);
                  }),
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'selectEmployee'.tr,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        DropdownButton<Role>(
                          value: selectedRole,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: Theme.of(context).textTheme.bodyLarge,
                          underline: Container(
                            height: 2,
                            color: AppTheme.mainGreen,
                          ),
                          onChanged: (Role? value) {
                            setState(() {
                              selectedRole = value!;
                            });
                          },
                          items: (List.from([Role.WAITER, Role.COOK]))
                              .map<DropdownMenuItem<Role>>((var value) {
                            return DropdownMenuItem<Role>(
                              value: value,
                              child: Text(
                                  value.toString().replaceFirst("Role.", "")),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width / 8, 50),
                              backgroundColor: AppTheme.mainYellow,
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: () async {
                              if (fromDate != null && toDate != null) {
                                setState(() {});
                              }
                            },
                            child: Text("search".tr)),
                      ],
                    );
                  }),
              const SizedBox(height: 60),
              BarChartWidget(
                  role: selectedRole, fromDate: fromDate, toDate: toDate),
            ],
          ))
        ]));
  }
}

class BarChartWidget extends StatefulWidget {
  BarChartWidget(
      {Key? key,
      required this.role,
      required this.fromDate,
      required this.toDate})
      : super(key: key);

  Role role = Role.WAITER;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  List<OrderModel> orders = [];
  fetchData() async {
    await analytics.logEvent(name: "view_charts");

    if (widget.fromDate != null) {
      if (widget.toDate != null && widget.toDate!.isAfter(DateTime.now())) {
        widget.toDate = null;
      }
      orders = await Provider.of<OrderViewModel>(context, listen: false)
          .fetchOrdersByTime(widget.fromDate!, widget.toDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  groupsSpace: 1,
                  barGroups: _chartGroups(),
                  borderData: FlBorderData(
                      border: const Border(
                          bottom: BorderSide(), left: BorderSide())),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        var users =
                            Provider.of<UserViewModel>(context, listen: false)
                                .userListMode
                                .where((user) => user.role == widget.role)
                                .toList();
                        if (index >= 0 && index < users.length) {
                          return Text(
                              "${users[index].firstName} ${users[index].lastName} ${orders.where((order) {
                            if (widget.role == Role.WAITER) {
                              return order.waiter.id == users[index].id;
                            } else {
                              return order.cook.id == users[index].id;
                            }
                          }).fold(0.0, (previousValue, order) => previousValue + order.price)}\$");
                        }
                        return const Text('');
                      },
                    )),
                    leftTitles: AxisTitles(
                        axisNameWidget: const Text("Ordini"),
                        sideTitles: SideTitles(
                            showTitles: true, reservedSize: 30, interval: 1)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            );
          }
        });
  }

  List<BarChartGroupData> _chartGroups() {
    var users = Provider.of<UserViewModel>(context, listen: false)
        .userListMode
        .where((user) => user.role == widget.role)
        .toList();
    print(orders);
    int i = 0;
    return users
        .map((e) => BarChartGroupData(x: i++, barRods: [
              BarChartRodData(
                  fromY: 0,
                  width: 30,
                  toY: orders
                      .where((order) {
                        if (widget.role == Role.WAITER) {
                          return order.waiter.id == e.id;
                        } else {
                          return order.cook.id == e.id;
                        }
                      })
                      .toList()
                      .length
                      .toDouble(),
                  color: AppTheme.mainGreen)
            ]))
        .toList();
  }
}
