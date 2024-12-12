import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/components/dashboard_card.dart';
import 'package:ratatouille23/src/features/dashboard/restaurantInformations.dart';
import 'package:ratatouille23/src/features/menu/listViewDishes.dart';
import 'package:ratatouille23/src/features/search/search.dart';
import 'package:ratatouille23/src/graphics/listDecoration.dart';
import 'package:ratatouille23/src/models/order_model.dart';
import 'package:ratatouille23/src/view_models/authenticate_view_model.dart';
import 'package:ratatouille23/src/view_models/order_view_model.dart';
import 'package:ratatouille23/src/view_models/user_view_model.dart';

final List<List<String>> ordini = <List<String>>[
  ['cotoletta x2', '\ncoca cola'],
  ['spaghetti x1', '\ngraffa x4', '\ncola x2'],
  ['spaghetti x1', '\ngraffa x4', '\nacqua x2', '\nchinotto x3'],
  ['cotoletta x2', '\ncoca cola'],
  ['spaghetti x1', '\ngraffa x4', '\ncola x2'],
  ['spaghetti x1', '\ngraffa x4', '\namatriciana x2', '\ncola x3'],
  ['cotoletta x2', '\ncoca cola'],
  ['spaghetti x1', '\ngraffa x4', '\ncola x2'],
  ['spaghetti x1', '\ngraffa x4', '\ncola x2', '\nchinotto x3']
];
final List<String> tavolo = <String>[
  '6',
  '1',
  '3',
  '6',
  '1',
  '3',
  '6',
  '1',
  '3'
];

class GridViewNotes extends StatefulWidget {
  const GridViewNotes({super.key});

  @override
  State<GridViewNotes> createState() => _GridViewNotesState();
}

class _GridViewNotesState extends State<GridViewNotes> {
  List<OrderModel> currentOrders = [];
  fetchData() async {
    await Provider.of<UserViewModel>(context, listen: false)
        .getUsers((errorMessage) {
      print(errorMessage);
    });
    var authViewModel =
        Provider.of<AuthenticateViewModel>(context, listen: false);
    int? id = Provider.of<UserViewModel>(context, listen: false)
        .userListMode
        .firstWhere((user) => user.email == authViewModel.email)
        .id;
    print(id);
    if (id != null) {
      currentOrders = await Provider.of<OrderViewModel>(context, listen: false)
          .fetchOrdersByUser(BigInt.from(id));
      print(currentOrders);
    }
  }

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
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
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: ordini.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width / 10,
                  padding: const EdgeInsets.all(5),
                  key: Key('$index'),
                  child: Card(
                    elevation: 2,
                    color: AppTheme.noteYellow,
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.horizontal,
                        secondaryBackground: Container(
                            color: AppTheme.mainGreen,
                            child: Row(children: const [
                              Expanded(child: SizedBox()),
                              Icon(
                                FeatherIcons.check,
                                size: 50,
                                color: AppTheme.mainWhite,
                              ),
                              SizedBox(width: 15),
                            ])),
                        onDismissed: (DismissDirection direction) async {
                          if (direction == DismissDirection.endToStart) {
                            await analytics.logEvent(name: "remove_order_cook");
                            //SE ELIMINI ORDINE
                            ordini.removeAt(index);
                            tavolo.removeAt(index);
                            setState(() {});
                          } else {
                            await analytics.logEvent(
                                name: "complete_order_cook");
                            //SE EVADI ORDINE
                            ordini.removeAt(index);
                            tavolo.removeAt(index);
                            setState(() {});
                          }
                        },
                        background: Container(
                            color: AppTheme.mainRed,
                            child: Row(children: const [
                              SizedBox(width: 15),
                              Icon(
                                FeatherIcons.trash2,
                                size: 50,
                                color: AppTheme.mainWhite,
                              ),
                              Expanded(child: SizedBox()),
                            ])),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyLarge,
                                children: <TextSpan>[
                                  TextSpan(text: '${ordini[index]}'),
                                  TextSpan(
                                      text: '\nTavolo ${tavolo[index]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
            );
          }
        });
  }
}
