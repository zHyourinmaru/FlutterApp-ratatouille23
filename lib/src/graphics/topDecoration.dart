import 'package:flutter/material.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopDecoration extends StatelessWidget {
  const TopDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SvgPicture.asset(
            'assets/images/rectangles_top_left.svg',
            alignment: Alignment.topLeft,
            height: MediaQuery.of(context).size.width / 5,
            width: MediaQuery.of(context).size.height / 15,
          ),
          const Spacer(),
        ]));
  }
}
