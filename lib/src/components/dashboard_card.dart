import 'package:flutter/material.dart';

class DashBoardCard extends StatelessWidget {
  final String caption;
  final Color cardColor;
  final Color iconColor;
  final String value;
  final Icon icon;

  const DashBoardCard(
      {super.key,
      required this.caption,
      required this.value,
      required this.cardColor,
      required this.iconColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 4.7,
          width: MediaQuery.of(context).size.width / 3.7,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        caption,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      value.toString(),
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Card(
                        elevation: 10,
                        color: iconColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 9,
                          width: MediaQuery.of(context).size.height / 9,
                          child: icon,
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              )
            ],
          ),
        ));
  }
}
