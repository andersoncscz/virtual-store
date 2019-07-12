import 'package:flutter/material.dart';
import 'package:virtual_store/screens/login/login_signin_screen.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({Key key}) : super(key: key);

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
