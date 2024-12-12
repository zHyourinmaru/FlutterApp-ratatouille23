import 'package:flutter/material.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomDecoration extends StatelessWidget {
  const BottomDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Row(children: [
          const Spacer(),
          SvgPicture.asset(
            'assets/images/rectangles_bottom_right.svg',
            alignment: Alignment.bottomRight,
            height: MediaQuery.of(context).size.width / 5,
            width: MediaQuery.of(context).size.height / 15,
          )
        ]));
  }
}
