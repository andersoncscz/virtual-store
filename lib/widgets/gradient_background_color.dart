import 'package:flutter/material.dart';

class GradientBackgroundColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
          Color.fromARGB(255, 81, 45, 168),
          Color.fromARGB(255, 123, 31, 162)
        ])),
    );
  }
}