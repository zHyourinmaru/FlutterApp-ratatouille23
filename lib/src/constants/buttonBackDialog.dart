import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ratatouille23/src/constants/theme.dart';

class ButtonBackDialog extends StatelessWidget {
  const ButtonBackDialog({super.key, this.onChanged});

  final Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.mainGreen,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
      ),
      width: 80,
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(children: [
        const SizedBox(height: 25),
        IconButton(
          icon: const Icon(
            FeatherIcons.arrowLeft,
            color: AppTheme.mainWhite,
            size: 50,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const Expanded(child: SizedBox()),
      ]),
    );
  }
}
