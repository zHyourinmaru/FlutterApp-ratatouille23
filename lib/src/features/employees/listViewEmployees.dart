import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/theme.dart';

import 'package:ratatouille23/src/features/employees/addEmployeeDialog.dart';
import 'package:ratatouille23/src/graphics/listDecoration.dart';
import 'package:ratatouille23/src/models/user_model.dart';
import 'package:ratatouille23/src/view_models/user_view_model.dart';

import 'buttonPerformance.dart';
import 'employeeDialog.dart';

class ListViewEmployees extends StatefulWidget {
  const ListViewEmployees({super.key});

  @override
  State<ListViewEmployees> createState() => _ListViewEmployeesState();
}

class _ListViewEmployeesState extends State<ListViewEmployees> {
  fetchData() async {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    await userViewModel.getUsers((errorMessage) {
      print(errorMessage);
    });
  }

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            UserViewModel userViewModel = Provider.of<UserViewModel>(context);
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: userViewModel.userListMode.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index != userViewModel.userListMode.length) {
                  UserModel user = userViewModel.userListMode[index];
                  return Container(
                    height: 80,
                    color: AppTheme.mainWhite,
                    child: ElevatedButton(
                        onPressed: () async {
                          await analytics.logEvent(name: "employee_dialog");
                          showDialog(
                              context: context,
                              builder: (_) => EmployeeDialog(employer: user));
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          shadowColor: Colors.black,
                          backgroundColor: AppTheme.mainWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Row(children: [
                              SizedBox(width: 30),
                              Icon(FeatherIcons.user,
                                  color: AppTheme.mainGreen, size: 50),
                              SizedBox(width: 65),
                              Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    '${user.firstName} ${user.lastName}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )),
                              DecoratorVertical(),
                              SizedBox(width: 10),
                              Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    user.role
                                        .toString()
                                        .replaceFirst("Role.", ""),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )),
                              DecoratorVertical(),
                              SizedBox(width: 20),
                              //ButtonPerfomanceEmployee(),
                            ]))),
                  );
                } else {
                  return ButtonAddEmployee();
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 20),
            );
          }
        });
  }
}

class ButtonAddEmployee extends StatelessWidget {
  ButtonAddEmployee({super.key});

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          //TODO: firebase analytics
          await analytics.logEvent(name: "create_employee");
          showDialog(context: context, builder: (_) => AddEmployeeDialog());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.mainYellow,
          textStyle: Theme.of(context).textTheme.labelLarge,
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text("+".tr));
  }
}
