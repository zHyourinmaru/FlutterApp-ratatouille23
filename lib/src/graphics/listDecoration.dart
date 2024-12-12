import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ratatouille23/src/components/dashboard_card.dart';
import 'package:ratatouille23/src/features/dashboard/restaurantInformations.dart';
import 'package:ratatouille23/src/features/employees/listViewEmployees.dart';
import 'package:ratatouille23/src/features/search/search.dart';

import '../constants/theme.dart';

class DecoratorVertical extends StatelessWidget {
  const DecoratorVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: AppTheme.mainGreen)),
      child: SizedBox(
        height: 55,
        width: 1.5,
      ),
    );
  }
}

class DecoratorVerticalLong extends StatelessWidget {
  const DecoratorVerticalLong({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: AppTheme.mainGreen)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.8,
        width: 1.5,
      ),
    );
  }
}

class DecoratorHorizontal extends StatelessWidget {
  const DecoratorHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: AppTheme.mainGreen)),
      child: SizedBox(
        height: 1.5,
        width: MediaQuery.of(context).size.width / 1.18,
      ),
    );
  }
}
