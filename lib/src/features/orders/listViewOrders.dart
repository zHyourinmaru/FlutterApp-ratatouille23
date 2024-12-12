import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/components/dashboard_card.dart';
import 'package:ratatouille23/src/features/dashboard/restaurantInformations.dart';
import 'package:ratatouille23/src/features/search/search.dart';
import 'package:ratatouille23/src/graphics/listDecoration.dart';
import 'package:ratatouille23/src/view_models/order_view_model.dart';

import 'orderDialog.dart';

class ListViewOrders extends StatefulWidget {
  ListViewOrders({super.key, required this.future});

  Future<Object?>? future;

  @override
  State<ListViewOrders> createState() => _ListViewOrdersState();
}

class _ListViewOrdersState extends State<ListViewOrders> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  fetchData() async {
    await widget.future;
    await analytics.logEvent(name: "view_orders");
  }

  @override
  Widget build(BuildContext context) {
    OrderViewModel orderViewModel =
        Provider.of<OrderViewModel>(context, listen: false);
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: orderViewModel
                  .totalOrders.length, // orderviewmodel.totalOrders.length
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 80,
                  color: AppTheme.mainWhite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.black,
                        backgroundColor: AppTheme.mainWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => OrderDialog(
                                  order: orderViewModel.totalOrders[index],
                                ));
                      },
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(children: [
                          Container(
                              width: 100,
                              child: Text(
                                '${orderViewModel.totalOrders[index].id}',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                          DecoratorVertical(),
                          Container(
                              width: MediaQuery.of(context).size.width / 6.5,
                              child: Text(
                                '${orderViewModel.totalOrders[index].started}',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                          DecoratorVertical(),
                          Container(
                              width: MediaQuery.of(context).size.width / 6.2,
                              child: Text(
                                "${orderViewModel.totalOrders[index].waiter.firstName ?? ""} ${orderViewModel.totalOrders[index].waiter.lastName ?? ""}",
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                          DecoratorVertical(),
                          Container(
                              width: MediaQuery.of(context).size.width / 6.2,
                              child: Text(
                                "${orderViewModel.totalOrders[index].cook.firstName ?? ""} ${orderViewModel.totalOrders[index].cook.lastName ?? ""}",
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                          DecoratorVertical(),
                          Container(
                              width: MediaQuery.of(context).size.width / 8,
                              child: Text(
                                (orderViewModel.totalOrders[index].completed ==
                                        null)
                                    ? "in lavorazione"
                                    : "completato",
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                          DecoratorVertical(),
                          Container(
                              width: MediaQuery.of(context).size.width / 14,
                              child: Text(
                                '${orderViewModel.totalOrders[index].price}\$',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                        ]),
                      )),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 20),
            );
          }
        });
  }
}
