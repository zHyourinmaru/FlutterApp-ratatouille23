import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ratatouille23/src/components/dashboard_card.dart';
import 'package:ratatouille23/src/features/dashboard/restaurantInformations.dart';
import 'package:ratatouille23/src/features/notes/gridViewNotes.dart';

import '../../constants/theme.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.mainWhite,
      padding: const EdgeInsets.fromLTRB(50, 40, 25, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TitleDashboard(),
              const Expanded(child: SizedBox()),
              Tooltip(
                  message: "tutorialCook".tr,
                  child: IconButton(
                      color: AppTheme.mainYellow,
                      onPressed: () {},
                      iconSize: 40,
                      icon: Icon(FeatherIcons.helpCircle)))
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: AppTheme.lightGray)),
                child: GridViewNotes()),
          )
        ],
      ),
    );
  }
}

class TitleDashboard extends StatelessWidget {
  const TitleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "orderInProgress".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
