import 'package:flutter/material.dart';
import 'package:ratatouille23/src/constants/theme.dart';
import 'package:ratatouille23/src/graphics/bottomDecoration.dart';
import 'package:ratatouille23/src/features/authentication/loginForm.dart';
import 'package:ratatouille23/src/graphics/topDecoration.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.mainGreen,
        body: Center(
          child: Stack(children: [
            const TopDecoration(),
            const BottomDecoration(),
            Column(children: [
              const Spacer(),
              Row(children: [
                const Spacer(),
                Image.asset(
                  'assets/images/logo_noback_whiteyellow1.png',
                  width: MediaQuery.of(context).size.width / 3.5,
                ),
                const Spacer(),
              ]),
              const SizedBox(height: 30),
              Row(
                children: [
                  Spacer(),
                  LoginForm(),
                  Spacer(),
                ],
              ),
              const Spacer(),
            ]),
          ]),
        ));
  }
}
