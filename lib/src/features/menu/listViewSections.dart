import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/features/menu/addDialog.dart';
import 'package:ratatouille23/src/features/menu/listViewDishes.dart';
import 'package:ratatouille23/src/models/dish_model.dart';
import 'package:ratatouille23/src/secure_storage_service.dart';
import 'package:ratatouille23/src/view_models/dish_view_model.dart';

import 'dishVisualizer.dart';

class ListViewSections extends StatefulWidget {
  const ListViewSections({super.key});

  @override
  State<ListViewSections> createState() => _ListViewSectionsState();
}

class _ListViewSectionsState extends State<ListViewSections> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          setState(() {});
        }));
  }

  final List<bool> _selected = [];
  final List<String> _sezioni = [];
  Map<String, dynamic> menu = {};

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  fetchData() async {
    String? value =
        await SecureStorageService.storage.read(key: "menuSections");
    menu = jsonDecode(value!);
    print(menu);
    _sezioni.clear();
    _sezioni.addAll(menu.keys);
    // TODO: aggiornare sezioni
    for (int i = 0; i < menu.keys.map((e) => false).length; i++) {
      if (i >= _selected.length) {
        _selected.add(false);
      }
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
            return ReorderableListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _sezioni.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index != _sezioni.length) {
                  return Container(
                      key: Key('$index'),
                      padding: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
                      height: 90,
                      color: AppTheme.mainWhite,
                      child: ElevatedButton(
                          onPressed: () async {
                            await analytics.logEvent(name: "select_section");
                            for (int i = 0; i < _sezioni.length; i++) {
                              if (i != index) {
                                _selected[i] = false;
                              } else {
                                if (_selected[i] == false) {
                                  _selected[i] = true;
                                  ListViewDishes.currentSection.value =
                                      menu[_sezioni[i]];
                                  ListViewDishes.selected.value = false;
                                  DishVisualizer.menuSelection.value =
                                      _sezioni[i];
                                  DishVisualizer.selected.value = false;
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
                            textStyle: Theme.of(context).textTheme.labelLarge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            '${_sezioni[index]}',
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
                              await analytics.logEvent(name: "add_section");
                              showDialog(
                                  context: context,
                                  builder: (_) => addDialog(
                                        string: 'section'.tr,
                                      ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.mainYellow,
                              textStyle: Theme.of(context).textTheme.labelLarge,
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
                await analytics.logEvent(name: "reorder_section");
                if (newIndex < _sezioni.length + 1) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final String item = _sezioni.removeAt(oldIndex);
                  _sezioni.insert(newIndex, item);
                }
              },
            );
          }
        });
  }
}
