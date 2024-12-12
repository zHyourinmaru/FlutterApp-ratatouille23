import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/constants/buttonBackDialog.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/models/role.dart';
import 'package:ratatouille23/src/models/user_model.dart';
import 'package:ratatouille23/src/view_models/user_view_model.dart';

import '../../constants/customTextFormField.dart';
import '../../constants/editTextDialog.dart';

class AddEmployeeDialog extends StatefulWidget {
  const AddEmployeeDialog({Key? key}) : super(key: key);

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).initUserToCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Form(key: _formKey, child: contentBox(context)),
    );
  }

  contentBox(context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: AppTheme.lightGray.withOpacity(0.25),
                offset: Offset(0, 10),
                blurRadius: 10),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ButtonBackDialog(
                onChanged: () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .initUserToCreate();
                },
              ),
              SizedBox(width: 50),
            ],
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                TitleEmployee(),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        "name".tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        "surname".tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: CustomTextFormField(
                          hintText: "name".tr,
                          onChanged: (value) {
                            userViewModel.userToCreate?.firstName = value;
                          },
                          onValidation: (value) {
                            if (value == "" || value == null) {
                              return '';
                            }
                            return null;
                          },
                        )),
                    SizedBox(width: 10),
                    CustomTextFormField(
                      hintText: "surname".tr,
                      onChanged: (value) {
                        userViewModel.userToCreate?.lastName = value;
                      },
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'email'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'password'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: CustomTextFormField(
                          hintText: "email".tr,
                          onChanged: (value) {
                            userViewModel.userToCreate?.email = value;
                          },
                        )),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: CustomTextFormField(
                            hintText: "password".tr,
                            onChanged: (value) {
                              //userViewModel.userToCreate?.password = value;
                            },
                          )),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Text(
                        'role'.tr,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: DropDownRole(),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                SizedBox(height: 40),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 20),
                        Container(
                            child: Row(children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Provider.of<UserViewModel>(context,
                                            listen: false)
                                        .initUserToCreate();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width / 8,
                                        50),
                                    backgroundColor: AppTheme.mainRed,
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Text("cancel".tr))),
                          SizedBox(width: 40),
                          Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    UserModel user = Provider.of<UserViewModel>(
                                            context,
                                            listen: false)
                                        .userToCreate!;
                                    print(user.firstName);
                                    if (user.email != null &&
                                        user.email != "" &&
                                        user.firstName != null &&
                                        user.firstName != "" &&
                                        user.lastName != null &&
                                        user.lastName != "") {
                                      BigInt? id =
                                          await Provider.of<UserViewModel>(
                                                  context,
                                                  listen: false)
                                              .createUser();
                                      if (id != null) {
                                        print("CREATO!!");
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width / 8,
                                        50),
                                    backgroundColor: AppTheme.mainYellow,
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Text("add".tr)))
                        ])),
                      ],
                    )),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class TitleEmployee extends StatelessWidget {
  const TitleEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "titleEmployee".tr,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

class DropDownRole extends StatefulWidget {
  @override
  State<DropDownRole> createState() => _DropDownRoleState();
}

class _DropDownRoleState extends State<DropDownRole> {
  Role role = Role.WAITER;

  @override
  Widget build(BuildContext context) {
    Provider.of<UserViewModel>(context, listen: false).userToCreate?.role =
        role;
    return DropdownButton<Role>(
      value: role,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: Theme.of(context).textTheme.bodyLarge,
      underline: Container(
        height: 2,
        color: AppTheme.mainGreen,
      ),
      onChanged: (Role? value) {
        // This is called when the user selects an item.
        Provider.of<UserViewModel>(context, listen: false).userToCreate?.role =
            value;
        setState(() {
          role = value!;
        });
      },
      items: Role.values.map<DropdownMenuItem<Role>>((var value) {
        return DropdownMenuItem<Role>(
          value: value,
          child: Text(value.toString().replaceFirst("Role.", "")),
        );
      }).toList(),
    );
  }
}

class ButtonAddCancel extends StatelessWidget {
  ButtonAddCancel();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Container(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                child: Text("cancel".tr))),
        SizedBox(width: 40),
        Container(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width / 8, 50),
                  backgroundColor: AppTheme.mainYellow,
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text("add".tr)))
      ]),
    );
  }
}
