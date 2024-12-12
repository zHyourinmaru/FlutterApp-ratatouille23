import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ratatouille23/src/constants/buttonBackDialog.dart';
import 'package:ratatouille23/src/constants/theme.dart';

import 'package:ratatouille23/src/features/employees/buttonPerformance.dart';
import 'package:ratatouille23/src/models/user_model.dart';

class EmployeeDialog extends StatelessWidget {

  EmployeeDialog({super.key, required this.employer});

  UserModel employer;

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
                offset: Offset(0, 10),
                blurRadius: 10),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
                SizedBox(height: 25),
                TitleEmployee(),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        "name".tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        "surname".tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        employer.firstName ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        employer.lastName ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'email'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'role'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        employer.email ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        employer.role.toString().replaceFirst("Role.", ""),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                SizedBox(height: 40),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        ButtonPerfomanceEmployee(),
                      ],
                    )),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleEmployee extends StatelessWidget {
  const TitleEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "titleEmployee".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
