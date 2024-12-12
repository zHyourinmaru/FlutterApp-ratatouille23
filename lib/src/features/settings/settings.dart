import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ratatouille23/src/graphics/listDecoration.dart';

import '../../constants/theme.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.mainWhite,
        padding: const EdgeInsets.fromLTRB(50, 40, 50, 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSettings(),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  SettingsAccountColumn(),
                  DecoratorVerticalLong(),
                  SizedBox(width: 25),
                  SettingsAppColumn(),
                ],
              ),
              SizedBox(height: 40),
              DecoratorHorizontal(),
              SizedBox(height: 20),
              Text(
                "Copyright 2023 Chill&Drink™ Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \“Software\”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ));
  }
}

class SettingsAppColumn extends StatelessWidget {
  const SettingsAppColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "app".tr,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          /*Text(
            "nightMode".tr,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SwitchMode(),*/
          SizedBox(height: 25),
          Text(
            "changeLanguage".tr,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SwitchLanguage(),
          SizedBox(height: 300),
          Row(
            children: [
              Expanded(child: SizedBox()),
              ButtonLogout(),
              SizedBox(width: 25),
            ],
          )
        ],
      )),
    );
  }
}

class SwitchLanguage extends StatefulWidget {
  const SwitchLanguage({super.key});

  @override
  State<SwitchLanguage> createState() => _SwitchLanguageState();
}

class _SwitchLanguageState extends State<SwitchLanguage> {
  bool english = false;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Row(children: [
          SizedBox(width: 25),
          Text("italian".tr,
              style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  color: AppTheme.mainGreen)),
          SizedBox(width: 25),
          Transform.scale(
              scale: 2,
              child: Switch(
                value: english,
                activeColor: AppTheme.mainYellow,
                onChanged: (bool value) async {
                  await analytics.logEvent(name: "change_language");
                  if (value == true) {
                    var locale = Locale('en', 'UK');
                    Get.updateLocale(locale);
                  } else {
                    var locale = Locale('it', 'IT');
                    Get.updateLocale(locale);
                  }
                  setState(() {
                    english = value;
                  });
                },
              )),
          SizedBox(width: 25),
          Text("english".tr,
              style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  color: AppTheme.mainGreen)),
        ]));
  }
}

/*class SwitchMode extends StatefulWidget {
  const SwitchMode({super.key});

  @override
  State<SwitchMode> createState() => _SwitchModeState();
}

class _SwitchModeState extends State<SwitchMode> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Row(children: [
          SizedBox(width: 25),
          Icon(FeatherIcons.sun, size: 40, color: AppTheme.mainGreen),
          SizedBox(width: 25),
          Transform.scale(
              scale: 2,
              child: Switch(
                value: dark,
                activeColor: AppTheme.mainYellow,
                onChanged: (bool value) {
                  if (value == false) {
                    AppTheme.darkMode = false;
                  } else {
                    AppTheme.darkMode = true;
                  }
                  setState(() {
                    dark = value;
                  });
                },
              )),
          SizedBox(width: 25),
          Icon(FeatherIcons.moon, size: 40, color: AppTheme.mainGreen),
        ]));
  }
}*/

class SettingsAccountColumn extends StatelessWidget {
  const SettingsAccountColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "account".tr,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 25),
          Text(
            "oldPassword".tr,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SettingsEditText(),
          SizedBox(height: 25),
          Text(
            "newPassword".tr,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SettingsEditText(),
          SizedBox(height: 25),
          Text(
            "confirmPassword".tr,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SettingsEditText(),
          SizedBox(height: 50),
          Row(
            children: [
              Expanded(child: SizedBox()),
              ButtonUpdatePassword(),
              SizedBox(width: 25),
            ],
          )
        ],
      )),
    );
  }
}

class SettingsEditText extends StatelessWidget {
  SettingsEditText({super.key});

  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shadowColor: Colors.black,
        color: AppTheme.mainWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: AppTheme.lightGray)),
        child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 3,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Row(
                  children: [
                    Container(
                      child: Expanded(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 6),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  height:
                                      MediaQuery.of(context).size.width / 5.5,
                                  child: TextFormField(
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ))))),
                    )
                  ],
                ))));
  }
}

class ButtonLogout extends StatelessWidget {
  ButtonLogout({super.key});

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: ElevatedButton(
            onPressed: () async {
              await analytics.logEvent(name: "logout");
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width / 8, 50),
              backgroundColor: AppTheme.mainRed,
              textStyle: Theme.of(context).textTheme.labelLarge,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text("logout".tr)));
  }
}

class ButtonUpdatePassword extends StatelessWidget {
  ButtonUpdatePassword({super.key});

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: ElevatedButton(
            onPressed: () async {
              await analytics.logEvent(name: "change_password");
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width / 8, 50),
              backgroundColor: AppTheme.mainYellow,
              textStyle: Theme.of(context).textTheme.labelLarge,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Text("buttonUpdate".tr)));
  }
}

class TitleSettings extends StatelessWidget {
  const TitleSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "titleSettings".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
