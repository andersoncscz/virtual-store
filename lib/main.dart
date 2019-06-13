import 'package:flutter/material.dart';
import 'package:virtual_store/screens/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 211, 118, 130),
      ),
      home: LoginScreen(),
      //home: HomeScreen(),
    );
  }
}
