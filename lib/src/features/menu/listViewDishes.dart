import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/view_models/dish_view_model.dart';

import 'dishVisualizer.dart';

class ListViewDishes extends StatefulWidget {
  const ListViewDishes({super.key});

  static ValueNotifier<bool> selected = ValueNotifier(false);
  static ValueNotifier<List<dynamic>> currentSection = ValueNotifier([]);

  @override
  State<ListViewDishes> createState() => _ListViewDishesState();
}

class _ListViewDishesState extends State<ListViewDishes> {
  List<bool> _selected = [false, false, false];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  fetchData() async {
    DishViewModel dishViewModel =
        Provider.of<DishViewModel>(context, listen: false);
    for (int id in ListViewDishes.currentSection.value) {
      print(id);
    }
  }

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ListViewDishes.currentSection,
      builder: (BuildContext context, List<dynamic> value, Widget? child) {
        print(ListViewDishes.currentSection.value);
        return FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ReorderableListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: ListViewDishes.currentSection.value.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index != ListViewDishes.currentSection.value.length) {
                      return Container(
                          key: Key('$index'),
                          padding: const EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
                          height: 90,
                          color: AppTheme.mainGreen,
                          child: ElevatedButton(
                              onPressed: () async {
                                await analytics.logEvent(name: "select_dish");
                                ListViewDishes.selected.value = true;
                                for (int i = 0;
                                    i <
                                        ListViewDishes
                                            .currentSection.value.length;
                                    i++) {
                                  if (i != index) {
                                    _selected[i] = false;
                                  } else {
                                    if (_selected[i] == false) {
                                      _selected[i] = true;
                                      //DishVisualizer.dishSelection.value = dishes[i];
                                      DishVisualizer.selected.value = true;
                                      DishVisualizer.create.value = false;
                                      setState(() {});
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                shadowColor: Colors.black,
                                backgroundColor: _selected[index] == true
                                    ? AppTheme.mainYellow
                                    : AppTheme.mainWhite,
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: Text(
                                "a",
                                //dishes[index][0],
                                style: _selected[index] == true
                                    ? Theme.of(context).textTheme.headlineSmall
                                    : Theme.of(context).textTheme.bodyLarge,
                              )));
                    } else {
                      return GestureDetector(
                          key: Key('$index'),
                          onLongPress: () {},
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await analytics.logEvent(name: "create_dish");
                                  // TODO: inizializzare il piatto da creare
                                  Provider.of<DishViewModel>(context,
                                          listen: false)
                                      .initDishToCreate();
                                  // _selected = [false, false, false];
                                  ListViewDishes.selected.value = false;
                                  DishVisualizer.create.value = true;
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.mainYellow,
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                  padding: EdgeInsets.fromLTRB(45, 20, 45, 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: Text("+".tr)),
                          ));
                    }
                  },
                  onReorder: (int oldIndex, int newIndex) async {
                    await analytics.logEvent(name: "reorder_dish");
                    if (newIndex < 1 + 1) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        //final List<String> item = dishes.removeAt(oldIndex);
                        //dishes.insert(newIndex, item);
                      });
                    }
                  },
                );
              }
            });
      },
    );
  }
}
