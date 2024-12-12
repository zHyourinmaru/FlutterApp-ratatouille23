import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ratatouille23/src/features/employees/listViewEmployees.dart';
import 'package:ratatouille23/src/features/search/search.dart';

import '../../constants/theme.dart';
import '../../graphics/listDecoration.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.mainWhite,
      padding: EdgeInsets.fromLTRB(50, 40, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleEmployees(),
          SizedBox(
            height: 25,
          ),
          EmployeesForm(),
          SizedBox(height: 8),
          DecoratorHorizontal(),
          Expanded(
              child: Row(children: [
            Expanded(child: ListViewEmployees()),
            SizedBox(width: 40),
          ])),
        ],
      ),
    );
  }
}

class TitleEmployees extends StatelessWidget {
  const TitleEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "titleEmployees".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class EmployeesForm extends StatelessWidget {
  const EmployeesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width / 8),
              Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Text("nameAndSurname".tr,
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              DecoratorVertical(),
              SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Text("role".tr,
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              DecoratorVertical(),
              SizedBox(width: 10),
              SearchBar(),
              SizedBox(width: 40),
            ],
          )),
    );
  }
}
