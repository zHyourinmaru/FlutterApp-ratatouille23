import 'package:flutter/material.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/features/sideNavigationBar/sideNavigationBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.mainGreen,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: const [
              SideNavigationBar(),
            ],
          ),
        ));
  }
}
