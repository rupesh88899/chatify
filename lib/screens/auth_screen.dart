
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/signup_page.dart';
import 'package:flutter/material.dart';

class AuthSwitchScreen extends StatefulWidget {
  const AuthSwitchScreen({super.key});

  @override
  State<AuthSwitchScreen> createState() => _AuthSwitchScreenState();
}

class _AuthSwitchScreenState extends State<AuthSwitchScreen> {
  bool isLogin = true;
  void toggleScreen() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ? SignInScreen() : SignupScreen();
  }
}
