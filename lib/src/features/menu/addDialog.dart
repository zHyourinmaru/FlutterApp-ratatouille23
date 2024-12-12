import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratatouille23/src/constants/buttonBackDialog.dart';
import 'package:ratatouille23/src/constants/customTextFormField.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/secure_storage_service.dart';

class addDialog extends StatelessWidget {
  addDialog({super.key, required this.string});

  String string;
  String sectionName = "";
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
      height: MediaQuery.of(context).size.height / 2.3,
      width: MediaQuery.of(context).size.width / 2.3,
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
                    TitleOrder(
                      hintText: string,
                    ),
                    SizedBox(height: 50),
                    CustomTextFormField(hintText: string, onChanged: (value) {
                      sectionName = value;
                    },),
                    SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () async {
                          String? value = await SecureStorageService.storage.read(key: "menuSections");
                          if (value != null) {
                            Map<String, dynamic> obj = jsonDecode(value);
                            obj[sectionName] = [];
                            if (sectionName != "") {
                              await SecureStorageService.storage.write(key: "menuSections", value: jsonEncode(obj));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.mainYellow,
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          padding: const EdgeInsets.fromLTRB(70, 5, 70, 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text("add".tr)),
                    const SizedBox(height: 25)
                  ]),
            ),
          ]),
    );
  }
}

class TitleOrder extends StatelessWidget {
  TitleOrder({super.key, required this.hintText});

  String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          hintText,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
