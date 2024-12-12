import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/features/dashboard/dashboard.dart';
import 'package:ratatouille23/src/features/employees/employees.dart';
import 'package:ratatouille23/src/features/graph/graph.dart';
import 'package:ratatouille23/src/secure_storage_service.dart';

import '../menu/menu.dart';
import '../notes/notes.dart';
import '../orders/orders.dart';
import '../settings/settings.dart';

class SideNavigationBar extends StatefulWidget {
  const SideNavigationBar({super.key});

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

List<bool> selected = [true, false, false, false, false, false];
int _selectedIndex = 0;

class _SideNavigationBarState extends State<SideNavigationBar> {
  final List<Widget> _screens = [
    Dashboard(),
    const Employees(),
    const Menu(),
    const Orders(),
    const Graphs(),
    const Settings(),
  ];

  void select(int n) {
    for (int i = 0; i < 6; i++) {
      if (i == n) {
        selected[i] = true;
      } else {
        selected[i] = false;
      }
    }
  }

  List<IconData> icon = [
    FeatherIcons.home,
    FeatherIcons.users,
    FeatherIcons.bookOpen,
    FeatherIcons.archive,
    FeatherIcons.barChart2,
    FeatherIcons.settings,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          select(0);
          _selectedIndex = icon.indexOf(FeatherIcons.home);
        }));
  }

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    // qua
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              color: AppTheme.mainWhite,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                  child: _screens[_selectedIndex])),
          Container(
            height: MediaQuery.of(context).size.height,
            width: 100.0,
            decoration: const BoxDecoration(
              color: AppTheme.mainGreen,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: icon
                        .map(
                          (e) => NavBarItem(
                            icon: e,
                            selected: selected[icon.indexOf(e)],
                            onTap: () async {
                              await analytics.logEvent(
                                  name: "change_view_navbar");
                              setState(() {
                                select(icon.indexOf(e));
                                _selectedIndex = icon.indexOf(e);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function onTap;
  final bool selected;

  const NavBarItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.selected,
  });
  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  late Animation<double> _anim1;
  late Animation<double> _anim2;
  late Animation<double> _anim3;
  late Animation<Color?> _color;

  bool hovered = false;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 275),
    );

    _anim1 = Tween(begin: 110.0, end: 70.0).animate(_controller1);
    _anim2 = Tween(begin: 110.0, end: 20.0).animate(_controller2);
    _anim3 = Tween(begin: 110.0, end: 45.0).animate(_controller2);
    _color = ColorTween(begin: Colors.white, end: AppTheme.mainGreen)
        .animate(_controller2);

    _controller1.addListener(() {
      setState(() {});
    });
    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.selected) {
      Future.delayed(const Duration(milliseconds: 10), () {
        //_controller1.reverse();
      });
      _controller1.reverse();
      _controller2.reverse();
    } else {
      _controller1.forward();
      _controller2.forward();
      Future.delayed(const Duration(milliseconds: 10), () {
        //_controller2.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: Container(
          width: 100.0,
          color:
              hovered && !widget.selected ? Colors.white12 : Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                child: CustomPaint(
                  size: const Size(0, 25),
                  painter: CurvePainter(
                    value1: 10,
                    animValue1: _anim3.value,
                    animValue2: _anim2.value,
                    animValue3: _anim1.value,
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
                width: 100.0,
                child: Center(
                  child: Icon(
                    widget.icon,
                    color: _color.value,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double value1; // 200
  final double animValue1; // static value1 = 50.0
  final double animValue2; //static value1 = 75.0
  final double animValue3; //static value1 = 75.0

  CurvePainter({
    required this.value1,
    required this.animValue1,
    required this.animValue2,
    required this.animValue3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(100, value1 - 20);
    path.quadraticBezierTo(100, value1 + 15, animValue3,
        value1 + 15); // have to use animValue3 for x2
    path.lineTo(animValue1, value1 + 15); // have to use animValue1 for x
    path.quadraticBezierTo(animValue2 - 10, value1 + 15, animValue2 - 10,
        value1 + 40); // animValue2 = 25 // have to use animValue2 for both x
    path.lineTo(100, value1 + 40);
    path.close();

    path.moveTo(100, value1 + 100);
    path.quadraticBezierTo(100, value1 + 65, animValue3, value1 + 65);
    path.lineTo(animValue1, value1 + 65);
    path.quadraticBezierTo(
        animValue2 - 10, value1 + 65, animValue2 - 10, value1 + 40);
    path.lineTo(100, value1 + 40);
    path.close();

    paint.color = Colors.white;
    paint.strokeWidth = 120.0;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
