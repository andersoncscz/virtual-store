import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  
  final _formKey = GlobalKey<FormState>();
  String _password = '';

  Widget _buildBodyBackground() => Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
          Theme.of(context).primaryColor,
          Color.fromARGB(255, 253, 181, 168)
        ])),
  );  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBodyBackground(),
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(30),
              children: <Widget>[
                SizedBox(height: 32),
                CustomTextFormField(
                  Icons.account_circle, 
                  'Informe o nome', 
                  'Nome', 
                  TextInputType.text, 
                  (text) {
                    if (text.isEmpty || text.length < 6)
                      return 'Nome inválido';
                  }
                ),
                SizedBox(height: 16),                
                CustomTextFormField(
                  Icons.email, 
                  'Informe o e-mail', 
                  'E-mail', 
                  TextInputType.emailAddress, 
                  (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return 'E-mail inválido';
                  }
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  Icons.lock, 
                  'Informe a senha', 
                  'Senha', 
                  TextInputType.text, 
                  (text) {
                    if (text.isEmpty || text.length < 6)
                      return 'Senha inválida';
                  },
                  obscureText: true,
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  Icons.lock, 
                  'Repita a senha', 
                  'Senha', 
                  TextInputType.text, 
                  (text) {
                    if (text.isEmpty || text != _password)
                      return 'Senha não confere';
                  },
                  obscureText: true,
                ),
                SizedBox(height: 32),                
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                      }
                    },
                    color: Colors.black,
                    child: Text('ENTRAR', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}