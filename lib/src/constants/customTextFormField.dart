import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/components/app_error_dialog.dart';

import 'package:ratatouille23/src/features/authentication/passwordRecoveryDialog.dart';

import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/view_models/authenticate_view_model.dart';

import '../service/api_status.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? onValidation;
  final bool obscureText;

  const CustomTextFormField(
      {super.key, this.hintText, this.onChanged, this.onValidation, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: [
            Card(
              elevation: 2,
              shadowColor: Colors.black,
              color: AppTheme.mainWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: AppTheme.lightGray),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: 40,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  validator: onValidation,
                  onChanged: onChanged,
                  obscureText: obscureText,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    errorStyle: Theme.of(context).textTheme.bodyMedium,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
