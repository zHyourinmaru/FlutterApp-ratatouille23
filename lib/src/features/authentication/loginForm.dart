import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ratatouille23/src/components/app_error_dialog.dart';

import 'package:ratatouille23/src/features/authentication/passwordRecoveryDialog.dart';

import 'package:ratatouille23/src/constants/customTextFormField.dart';

import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/view_models/authenticate_view_model.dart';

import '../../service/api_status.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  void _onError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Errore'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    AuthenticateViewModel authenticateViewModel =
        context.watch<AuthenticateViewModel>();
    return Form(
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        color: AppTheme.mainWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 2,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: const LoginTextTitle()),
              Align(
                alignment: Alignment.center,
                child: Column(children: [
                  CustomTextFormField(
                    hintText: "email".tr,
                    onChanged: (email) async {
                      // TODO: CAMBIARE IN PRODUCTION
                      //authenticateViewModel.authenticatingUser.email = email;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: "password".tr,
                    onChanged: (password) async {
                      // TODO: CAMBIARE IN PRODUCTION
                      //authenticateViewModel.authenticatingUser.password =
                      //  password;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () async {
                        await analytics.logEvent(name: "login");

                        // Se sta effettuando la richiesta non ne manda altre
                        if (authenticateViewModel.loading) {
                          return;
                        }
                        // Mostra caricamento
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Loading"),
                              );
                            });
                        authenticateViewModel.authenticatingUser.password =
                            "123";
                        authenticateViewModel.authenticatingUser.email =
                            "arena@email.com";
                        await authenticateViewModel
                            .authenticate((errorMessage) {
                          Navigator.pop(context);
                          _onError(context, errorMessage);
                        });

                        // Necessario all'interno di funzioni async
                        if (context.mounted) {
                          // Se tutto ok vai alla schermata
                          if (authenticateViewModel.authenticated) {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/home');
                          }
                        }
                        //Navigator.pop(context);
                        //Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.mainYellow,
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        padding: const EdgeInsets.fromLTRB(70, 5, 70, 7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text("buttonLogin".tr)),
                ]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: const [ForgotPasswordForm()],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall,
            children: <TextSpan>[
              TextSpan(text: 'forgotPassword'.tr),
              TextSpan(
                text: 'clickHere'.tr,
                style: Theme.of(context).textTheme.labelSmall,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => showDialog(
                      context: context,
                      builder: (_) => PasswordRecoveryDialog()),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class LoginTextTitle extends StatelessWidget {
  const LoginTextTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 30.0),
        child: Text(
          "titleLogin".tr,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
