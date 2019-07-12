import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/home/home_screen.dart';
import 'package:virtual_store/widgets/gradient_background_color.dart';

import 'custom_text_form_field.dart';
import 'login_signup_screen.dart';

class LoginSignInScreen extends StatefulWidget {

  @override
  _LoginSignInScreenState createState() => _LoginSignInScreenState();
}

class _LoginSignInScreenState extends State<LoginSignInScreen> {
  
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          GradientBackgroundColor(),
          Padding(
            padding: EdgeInsets.all(22),
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      height: 170,
                      child: Image.asset('assets/images/logo.png', fit: BoxFit.scaleDown),
                    )
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    _emailController,
                    Icons.email,
                    'Informe o e-mail',
                    'E-mail',
                    TextInputType.emailAddress,
                    validateEmail
                  ),
                  
                  CustomTextFormField(
                    _passwordController,
                    Icons.lock,
                    'Informe a senha',
                    'Senha',
                    TextInputType.text,
                    validatePassword,
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
                            onPressed: UserModel.of(context).isLoading ? null : () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSignUpScreen())),
                            child: Text('Criar uma conta', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: UserModel.of(context).isLoading ? null : _handleRecovePassword,
                            child: Text('Recuperar a senha', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: UserModel.of(context).isLoading 
                      ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) 
                      : RaisedButton(
                        onPressed: _handleSignIn,
                        color: Colors.white,
                        child: Text('ENTRAR', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColorDark)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  void _handleRecovePassword() {
    if (_emailController.text.isNotEmpty) {
      UserModel.of(context).recoverPassword(_emailController.text);
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: const Text('Verifique sua caixa de email!'),
        )
      );         
    }
    else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: const Text('Informe o email!'),
        )
      );      
    }
  }

  validateEmail(String email) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    if (!emailValid)
      return 'E-mail inválido';
    return null;
  }

  validatePassword(String password) {
    if (password.length < 6)
      return 'Senha inválida';
    return null;
  }  

  void _handleSignIn() {
    
    if (!_autoValidate) {
      setState(() {
        _autoValidate = true;
      });
    }

    if (_formKey.currentState.validate()) {
      Map<String, dynamic> user = { 'email': _emailController.text };      
      UserModel.of(context).signInWithCredentials(user: user, password: _passwordController.text, onFail: _onFail, onSucess: _onSucess);
    }    
  }

  void _onSucess() {
    CartModel.of(context).user = UserModel.of(context);
    CartModel.of(context).getCartItems();
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: const Text('Erro ao logar-se!'),
      )
    );
  }
}
