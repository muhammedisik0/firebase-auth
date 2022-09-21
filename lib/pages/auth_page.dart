import 'package:firebase_authentication/widgets/login_widget.dart';
import 'package:firebase_authentication/widgets/register_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoginWidget = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoginWidget ? LoginWidget(onTapSignUp: toggleWidget) : RegisterWidget(onTapLogIn: toggleWidget),
      ),
    );
  }

  void toggleWidget() {
    setState(() => isLoginWidget = !isLoginWidget);
  }
}
