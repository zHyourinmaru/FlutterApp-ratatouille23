import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/models/role.dart';
import 'package:ratatouille23/src/view_models/user_view_model.dart';

import '../../view_models/table_view_model.dart';

class RestaurantInformations extends StatefulWidget {
  const RestaurantInformations({super.key});

  @override
  State<RestaurantInformations> createState() => _RestaurantInformationsState();
}

class _RestaurantInformationsState extends State<RestaurantInformations> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  fetchData(UserViewModel userViewModel) async {
    userViewModel.getTotalEmployeeCount(role: Role.COOK);
    userViewModel.getTotalEmployeeCount(role: Role.WAITER);
    userViewModel.getTotalEmployeeCount(role: Role.SUPERVISOR);
    userViewModel.getTotalEmployeeCount();
    await analytics.logEvent(name: "view_resturant_informations");
  }

  @override
  void initState() {
    super.initState();
    fetchData(Provider.of<UserViewModel>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, _) {
      if (userViewModel.loading) {
        return const Text("Is loading...");
      }
      return Container(
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
                  Text(
                    "restaurantInformations".tr,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "numberOfTables".tr,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 5),
                  NumberTableEditText(),
                  const SizedBox(height: 10),
                  Text(
                    "totalEmployees".tr,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userViewModel.loading
                        ? "is loading..."
                        : userViewModel.totalEmployeeCount.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "supervisors".tr,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userViewModel.loading
                        ? "is loading..."
                        : userViewModel.supervisorsCount.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "roomAttendants".tr,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userViewModel.loading
                        ? "is loading..."
                        : userViewModel.waitersCount.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "kitchenAttendants".tr,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userViewModel.loading
                        ? "is loading..."
                        : userViewModel.cookersCount.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ]),
          ),
        ),
      );
    });
  }
}

class NumberTableEditText extends StatefulWidget {
  const NumberTableEditText({super.key});

  @override
  State<NumberTableEditText> createState() => _NumberTableEditTextState();
}

class _NumberTableEditTextState extends State<NumberTableEditText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TableViewModel>(context, listen: false)
          .fetchTotalTableNumber(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("is loading...");
        } else {
          return Row(children: [
            Card(
                elevation: 2,
                shadowColor: Colors.black,
                color: AppTheme.mainWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: AppTheme.lightGray)),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    height: 35,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: TextField(
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: Provider.of<TableViewModel>(context)
                                .totalTableNumber
                                .toString(),
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            labelStyle: Theme.of(context).textTheme.bodySmall,
                          )),
                    ))),
            Container(
                padding: const EdgeInsets.only(left: 5),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 13, 30),
                      backgroundColor: AppTheme.mainYellow,
                      textStyle: Theme.of(context).textTheme.labelMedium,
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text("buttonUpdate".tr)))
          ]);
        }
      },
    );
  }
}
