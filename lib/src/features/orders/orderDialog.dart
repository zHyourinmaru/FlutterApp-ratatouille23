import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratatouille23/src/constants/buttonBackDialog.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/models/order_model.dart';

class OrderDialog extends StatelessWidget {
  OrderDialog({super.key, required this.order});

  OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: AppTheme.lightGray.withOpacity(0.25),
                offset: const Offset(0, 10),
                blurRadius: 10),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              ButtonBackDialog(),
              SizedBox(width: 50),
            ],
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                const TitleOrder(),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        "id".tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        "date".tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    InformationBox(
                      information: order.id.toString(),
                    ),
                    const SizedBox(width: 10),
                    InformationBox(
                      information: order.started.toString(),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'roomAttendant'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'kitchenAttendant'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InformationBox(
                      information:  "${order.waiter.firstName ?? ""} ${order.waiter.lastName ?? ""}" ,
                    ),
                    const SizedBox(width: 10),
                    InformationBox(
                      information: "${order.cook.firstName ?? ""} ${order.cook.lastName ?? ""}",
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'status'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'table'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InformationBox(
                      information: (order.completed != null) ? "completed" : "not completed",
                    ),
                    const SizedBox(width: 10),
                    InformationBox(
                      information: order.table.toString(),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'completionTime'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'amount'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InformationBox(
                      information: order.completed == null ? "not completed" : order.completed.toString(),
                    ),
                    const SizedBox(width: 10),
                    InformationBox(
                      information: '${order.price}\$',
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleOrder extends StatelessWidget {
  const TitleOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "titleOrder".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class InformationBox extends StatelessWidget {
  final String information;
  const InformationBox({super.key, required this.information});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Text(
        information,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
