import 'package:flutter/material.dart';
import 'package:virtual_store/screens/login/login_signin_screen.dart';

enum FormMode { LOGIN, SIGNUP }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginSignInScreen(),
    );
  }
}
