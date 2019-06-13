import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  
    
    final IconData icon;
    final String hintText;
    final String labelText;
    final TextInputType keyboardType;
    final Function validator;
    final bool obscureText;

    CustomTextFormField(this.icon, this.hintText, this.labelText, this.keyboardType, this.validator, { this.obscureText: false });

  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    
    return Theme(
      data: theme.copyWith(primaryColor: Colors.white, hintColor: Colors.grey[800], errorColor: Colors.redAccent),
      child: TextFormField(
        style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          errorStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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