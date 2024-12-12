import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ratatouille23/src/constants/theme.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
            width: 300,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Row(
                  children: [
                    Container(
                        child: const Icon(
                      FeatherIcons.search,
                      color: AppTheme.mainYellow,
                      size: 28,
                    )),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 6),
                            child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: TextField(
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "search".tr,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ))))),
                  ],
                ))));
  }
}
