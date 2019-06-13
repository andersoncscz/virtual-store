import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:virtual_store/screens/home/home_screen.dart';
import 'package:virtual_store/screens/login/login_signup_screen.dart';

import 'custom_text_form_field.dart';

class LoginSignInScreen extends StatefulWidget {
  @override
  _LoginSignInScreenState createState() => _LoginSignInScreenState();
}

class _LoginSignInScreenState extends State<LoginSignInScreen> {
  
  
  final _formKey = GlobalKey<FormState>();

  
  Widget _buildBodyBackground() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
        Color.fromARGB(255, 211, 118, 130),
        Color.fromARGB(255, 253, 181, 168)
      ])),
  );  
  

  Widget _buildSignInForm() => Form(
    key: _formKey,
    child: ListView(
      padding: EdgeInsets.all(30),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            height: 250,
            child: Image.asset('assets/images/logo.png', fit: BoxFit.scaleDown),
          )
        ),
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
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LoginSignUpScreen()
                    ));
                  },
                  child: Text('Criar uma conta', textAlign: TextAlign.right, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 16)),
                  padding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Esqueci minha senha', textAlign: TextAlign.right, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 16)),
                  padding: EdgeInsets.zero,
                ),
              ),                      
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 44,
          child: RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HomeScreen()
                ));
              }
            },
            color: Colors.black,
            child: Text('ENTRAR', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ),
      ],
    ),
  );


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBodyBackground(),
          _buildSignInForm()
        ],
      )
    );
  }

}