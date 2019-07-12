import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  
    final TextEditingController controller;
    final IconData icon;
    final String hintText;
    final String labelText;
    final TextInputType keyboardType;
    final Function validator;
    final bool obscureText;

    CustomTextFormField(this.controller, this.icon, this.hintText, this.labelText, this.keyboardType, this.validator, {this.obscureText: false });

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    
    return Theme(
      data: theme.copyWith(
        primaryColor: Theme.of(context).accentColor, 
        hintColor: Colors.white, 
        errorColor: Colors.red
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          errorStyle: TextStyle(fontSize: 14),
          hintText: hintText,
          labelText: labelText
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: (text) => validator(text),
      ),
    );
  }
}