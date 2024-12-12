import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/features/menu/listViewDishes.dart';
import 'package:ratatouille23/src/models/dish_model.dart';
import 'package:ratatouille23/src/view_models/dish_view_model.dart';

import '../../constants/valueListenableBuilder3.dart';
import '../../secure_storage_service.dart';
import '../../view_models/allergen_view_model.dart';

class DishVisualizer extends StatefulWidget {
  const DishVisualizer({super.key});

  static ValueNotifier<String> menuSelection = ValueNotifier("");
  static ValueNotifier<bool> selected = ValueNotifier(false);
  static ValueNotifier<bool> create = ValueNotifier(false);

  @override
  State<DishVisualizer> createState() => _DishVisualizerState();
}

class _DishVisualizerState extends State<DishVisualizer> {
  @override
  Widget build(BuildContext context) {
    //TODO: funzione che ritorna i piatti per sezione
    return ValueListenableBuilder3(
        first: DishVisualizer.menuSelection,
        second: DishVisualizer.selected,
        third: DishVisualizer.create,
        builder: (BuildContext context, String menuSection, bool selected,
            bool create, Widget? child) {
          return menuSection != "" && selected == true && create == false
              ? EditDish(
                  dish: Provider.of<DishViewModel>(context, listen: false)
                      .selectedDish,
                  createMode: false)
              : create == false
                  ? TutorialPlaceholder()
                  : EditDish(
                      createMode: true,
                      dish: Provider.of<DishViewModel>(context, listen: false)
                          .dishToCreate,
                    );
        });
  }
}

class TutorialPlaceholder extends StatelessWidget {
  TutorialPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.mainWhite,
        child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 2,
              child: Card(
                elevation: 3,
                color: AppTheme.mainGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo_noback_whiteyellow1.png',
                            width: MediaQuery.of(context).size.width / 3.5,
                          ),
                          Text(
                            "tutorialMenu".tr,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ])),
              )),
        ));
  }
}

class EditDish extends StatelessWidget {
  EditDish({super.key, required this.dish, required this.createMode});

  DishModel? dish;
  bool createMode;

  @override
  Widget build(BuildContext context) {
    print(Provider.of<DishViewModel>(context, listen: false).dishToCreate);
    if (dish == null) {
      return const Center();
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 40, 50, 40),
      color: AppTheme.mainWhite,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "dishName".tr,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        DishNameEditText(
          name: createMode == false ? dish?.name ?? "" : "create",
          onChanged: (value) {
            dish?.name = value;
          },
        ),
        const SizedBox(height: 10),
        Text(
          "price".tr,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        DishPriceEditText(
          price: createMode == false ? dish?.price.toString() ?? "" : "create",
          onChanged: (value) {
            dish?.price = int.parse(value).toDouble();
          },
        ),
        Text(
          "description".tr,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        DishDescEditText(
            desc: createMode == false
                ? dish?.description.toString() ?? ""
                : "create",
            onChanged: (value) {
              dish?.description = value;
            }),
        Text(
          "allergens".tr,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 6,
          child: FutureBuilder(
              future: Provider.of<AllergenViewModel>(context, listen: false)
                  .getAllergen((errorMessage) {
                print(errorMessage);
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Wrap(children: [
                      // if sei supervisore
                      for (var allergen in Provider.of<AllergenViewModel>(
                              context,
                              listen: false)
                          .allergenModelList)
                        DishTag(
                            selected: createMode == false ? "a" : "false",
                            name: allergen.name)
                      // endif supervisore
                      // else non sei supervisore ti prendi quelli del piatto e li listi

                      // endif
                    ]),
                  );
                }
              }),
        ),
        Expanded(
            child: Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: MediaQuery.of(context).size.width / 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonCancel(),
                    ButtonAdd(),
                  ],
                )))
      ]),
    );
  }
}

class DishDescEditText extends StatelessWidget {
  DishDescEditText({super.key, required this.desc, required this.onChanged});
  Function(String)? onChanged;
  String desc;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black,
      color: AppTheme.mainWhite,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: AppTheme.lightGray)),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 6.5,
        width: MediaQuery.of(context).size.width / 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.width / 6,
                          child: TextFormField(
                              key: Key(desc),
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              initialValue: desc == "create" ? "" : desc,
                              style: Theme.of(context).textTheme.bodyLarge,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: desc != "create" ? "" : "desc".tr,
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ))))),
            ],
          ),
        ),
      ),
    );
  }
}

class DishPriceEditText extends StatelessWidget {
  DishPriceEditText({super.key, required this.price, required this.onChanged});

  Function(String)? onChanged;
  String price;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Card(
        elevation: 2,
        shadowColor: Colors.black,
        color: AppTheme.mainWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: AppTheme.lightGray)),
        child: SizedBox(
          height: 50,
          width: 60,
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          width: MediaQuery.of(context).size.width / 10.5,
                          child: TextFormField(
                              key: Key(price),
                              textAlign: TextAlign.end,
                              initialValue: price == "create" ? "" : price,
                              style: Theme.of(context).textTheme.bodyLarge,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: price != "create" ? "" : "price".tr,
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ))))),
            ],
          ),
        ),
      ),
      Text(
        '€',
        style: Theme.of(context).textTheme.displayLarge,
      ),
    ]);
  }
}

class DishNameEditText extends StatelessWidget {
  String name;
  Function(String)? onChanged;
  DishNameEditText({super.key, required this.name, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black,
      color: AppTheme.mainWhite,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: AppTheme.lightGray)),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width / 3,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: TextFormField(
                    onChanged: onChanged,
                    key: Key(name),
                    initialValue: name == "create" ? "" : name,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: name != "create" ? "" : "dishName".tr,
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DishTag extends StatefulWidget {
  DishTag({super.key, required this.selected, required this.name});

  String selected;
  String name;

  @override
  State<DishTag> createState() => _DishTagState();
}

class _DishTagState extends State<DishTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
        height: 35,
        child: ElevatedButton(
            onPressed: () {
              if (widget.selected == 'true') {
                widget.selected = 'false';
              } else {
                widget.selected = 'true';
              }
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shadowColor: Colors.black,
              backgroundColor: widget.selected == 'false'
                  ? AppTheme.mainWhite
                  : AppTheme.mainYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Text(
              widget.name,
              style: widget.selected == 'false'
                  ? Theme.of(context).textTheme.bodySmall
                  : Theme.of(context).textTheme.labelMedium,
            )));
  }
}

class ButtonCancel extends StatelessWidget {
  ButtonCancel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: ElevatedButton(
            onPressed: () {
              DishVisualizer.selected.value = false;
              ListViewDishes.selected.value = false;
              DishVisualizer.create.value = false;
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width / 8, 50),
              backgroundColor: AppTheme.mainRed,
              textStyle: Theme.of(context).textTheme.labelLarge,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text("cancel".tr)));
  }
}

class ButtonAdd extends StatelessWidget {
  ButtonAdd({super.key});

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: ElevatedButton(
            onPressed: () async {
              await analytics.logEvent(name: "update_dish");
              // TODO: differenzia create mode
              if (DishVisualizer.create.value == true) {
                DishViewModel viewModel =
                    Provider.of<DishViewModel>(context, listen: false);
                // TODO: aggiungi piatto alla sezione corrente
                int? dishID = await viewModel.createDish();
                if (dishID != null) {
                  String? value = await SecureStorageService.storage
                      .read(key: "menuSections");
                  var new_menu = jsonDecode(value!);
                  (new_menu[DishVisualizer.menuSelection.value]
                          as List<dynamic>)
                      .add(dishID);
                  await SecureStorageService.storage
                      .write(key: "menuSections", value: jsonEncode(new_menu));
                }
              }
              //TODO: manda query per creare piatto o aggiornarlo
              DishVisualizer.selected.value = false;
              ListViewDishes.selected.value = false;
              DishVisualizer.create.value = false;
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width / 8, 50),
              backgroundColor: AppTheme.mainYellow,
              textStyle: Theme.of(context).textTheme.labelLarge,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text("add".tr)));
  }
}
