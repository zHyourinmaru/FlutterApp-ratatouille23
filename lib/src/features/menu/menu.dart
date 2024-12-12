import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ratatouille23/src/features/menu/dishVisualizer.dart';
import 'package:ratatouille23/src/features/menu/listViewDishes.dart';
import 'package:ratatouille23/src/features/menu/listViewSections.dart';
import 'package:ratatouille23/src/secure_storage_service.dart';
import '../../constants/theme.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  fetchData() async {
    String? value = await SecureStorageService.storage.read(key: "menuSections");
    if (value == null) {
      SecureStorageService.storage.write(key: "menuSections", value: jsonEncode({}));
    } else {
      String? value = await SecureStorageService.storage.read(key: "menuSections");
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return Container(
            color: AppTheme.mainWhite,
            child: Row(children: [
              SectionsContainer(),
              DishesContainer(),
              Expanded(child: DishVisualizer()),
            ]),
          );
        }

      }
    );
  }
}

class DishesContainer extends StatefulWidget {
  const DishesContainer({super.key});

  @override
  State<DishesContainer> createState() => _DishesContainerState();
}

class _DishesContainerState extends State<DishesContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 4,
        color: AppTheme.mainWhite,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.mainGreen,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "dishes".tr,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                padding: EdgeInsets.fromLTRB(50, 80, 0, 0),
              ),
              SizedBox(height: 25),
              Expanded(
                  child: Row(children: [
                SizedBox(width: 40),
                Expanded(child: ListViewDishes()),
                SizedBox(width: 20),
              ])),
            ],
          ),
        ));
  }
}

class SectionsContainer extends StatelessWidget {
  const SectionsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 4,
      color: AppTheme.mainGreen,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: TitleMenu(),
                padding: EdgeInsets.fromLTRB(50, 40, 0, 0),
              ),
              SizedBox(height: 25),
              Expanded(
                  child: Row(children: [
                SizedBox(width: 40),
                Expanded(child: ListViewSections()),
                SizedBox(width: 20),
              ])),
            ],
          )),
    );
  }
}

class TitleMenu extends StatelessWidget {
  const TitleMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "titleMenu".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
        Text(
          "sections".tr,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
