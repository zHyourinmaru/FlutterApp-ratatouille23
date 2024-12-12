import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/components/dashboard_card.dart';
import 'package:ratatouille23/src/features/dashboard/restaurantInformations.dart';
import 'package:ratatouille23/src/service/order_services.dart';
import 'package:ratatouille23/src/view_models/authenticate_view_model.dart';
import 'package:ratatouille23/src/view_models/order_view_model.dart';
import 'package:ratatouille23/src/view_models/user_view_model.dart';

import '../../constants/theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.mainWhite,
        padding: const EdgeInsets.fromLTRB(50, 40, 0, 0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleDashboard(),
              const SizedBox(
                height: 100,
              ),
              Row(
                children: const [
                  RestaurantInformations(),
                  SizedBox(width: 30),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: OrderSection(),
                  ),
                  SizedBox(width: 10),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: MoneySection(),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class MoneySection extends StatefulWidget {
  const MoneySection({
    super.key,
  });

  @override
  State<MoneySection> createState() => _MoneySectionState();
}

class _MoneySectionState extends State<MoneySection> {
  fetchData() async {
    OrderViewModel viewModel =
        Provider.of<OrderViewModel>(context, listen: false);
    DateTime now = DateTime.now();
    await viewModel.fetchTotalRevenues(time: DateTime(now.year, now.month, 1));
    await viewModel.fetchTotalRevenues(time: DateTime(now.year, 1, 1));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          OrderViewModel viewModel =
              Provider.of<OrderViewModel>(context, listen: false);
          return Column(
            children: [
              DashBoardCard(
                caption: "salesForThisMonth".tr,
                value: viewModel.totalMonthRevenues.toString(),
                cardColor: AppTheme.mainYellow,
                iconColor: AppTheme.mainGreen,
                icon: Icon(
                  FeatherIcons.checkCircle,
                  color: AppTheme.mainWhite,
                  size: MediaQuery.of(context).size.height / 14,
                ),
              ),
              const SizedBox(height: 15),
              DashBoardCard(
                caption: "salesForThisYear".tr,
                value: viewModel.totalYearRevenues.toString(),
                cardColor: AppTheme.mainYellow,
                iconColor: AppTheme.mainGreen,
                icon: Icon(
                  FeatherIcons.checkCircle,
                  color: AppTheme.mainWhite,
                  size: MediaQuery.of(context).size.height / 14,
                ),
              )
            ],
          );
        });
  }
}

class OrderSection extends StatefulWidget {
  const OrderSection({
    super.key,
  });

  @override
  State<OrderSection> createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  fetchData() async {
    OrderViewModel viewModel =
        Provider.of<OrderViewModel>(context, listen: false);
    DateTime now = DateTime.now();
    await viewModel.fetchTotalOrders(time: DateTime(now.year, now.month, 1));
    await viewModel.fetchTotalOrders(time: DateTime(now.year, 1, 1));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          OrderViewModel orderViewModel =
              Provider.of<OrderViewModel>(context, listen: false);
          return Column(
            children: [
              DashBoardCard(
                caption: "ordersOfThisMonth".tr,
                value: orderViewModel.totalMonthOrders.toString(),
                cardColor: AppTheme.mainGreen,
                iconColor: AppTheme.mainYellow,
                icon: Icon(
                  FeatherIcons.checkCircle,
                  color: AppTheme.mainWhite,
                  size: MediaQuery.of(context).size.height / 14,
                ),
              ),
              const SizedBox(height: 15),
              DashBoardCard(
                caption: "ordersOfThisYear".tr,
                value: orderViewModel.totalYearOrders.toString(),
                cardColor: AppTheme.mainGreen,
                iconColor: AppTheme.mainYellow,
                icon: Icon(
                  FeatherIcons.checkCircle,
                  color: AppTheme.mainWhite,
                  size: MediaQuery.of(context).size.height / 14,
                ),
              )
            ],
          );
        });
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
          "titleDashboard".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
        Text(
          "${"welcome".tr}",
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
