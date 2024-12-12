import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratatouille23/src/constants/buttonBackDialog.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/constants/customTextFormField.dart';

class ChangePasswordDialog extends StatelessWidget {
  ChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.2,
      width: MediaQuery.of(context).size.width / 2.2,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: AppTheme.lightGray.withOpacity(0.25),
                offset: const Offset(0, 10),
                blurRadius: 10),
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                ButtonBackDialog(),
                SizedBox(width: 50),
              ],
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    const Title(),
                    SizedBox(height: 50),
                    CustomTextFormField(hintText: "password".tr),
                    SizedBox(height: 25),
                    CustomTextFormField(hintText: "confirmPassword".tr),
                    SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.mainYellow,
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          padding: const EdgeInsets.fromLTRB(70, 5, 70, 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text("send".tr)),
                    const SizedBox(height: 25)
                  ]),
            ),
          ]),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "account".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
